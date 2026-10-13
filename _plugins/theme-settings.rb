#!/usr/bin/env ruby
#
# Let _data/theme.yml (edited in Pages CMS) override site identity from _config.yml,
# so the CMS never has to rewrite _config.yml itself.

Jekyll::Hooks.register :site, :post_read do |site|
  theme = site.data["theme"]
  next unless theme.is_a?(Hash)

  %w(title tagline description avatar).each do |key|
    value = theme[key].to_s.strip
    site.config[key] = value unless value.empty?
  end

  author = theme["author"].to_s.strip
  unless author.empty?
    site.config["social"] ||= {}
    site.config["social"]["name"] = author
  end
end

# Pick dark or light text for elements filled with the primary color.
Jekyll::Hooks.register :site, :post_read do |site|
  theme = site.data["theme"]
  next unless theme.is_a?(Hash)

  hex = theme["primary_color"].to_s.delete("#")
  hex = hex.chars.map { |c| c * 2 }.join if hex.length == 3
  next unless hex.match?(/\A\h{6}\z/)

  r, g, b = hex.scan(/../).map { |c| c.to_i(16) / 255.0 }
  luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
  theme["on_primary"] = luminance > 0.5 ? "#1b1505" : "#ffffff"
end
