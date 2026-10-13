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

# Load the fonts chosen in _data/theme.yml instead of the theme's Lato/Source Sans Pro,
# which lack Vietnamese glyphs. Only 400/700 are requested so any Google font works.
Jekyll::Hooks.register :site, :post_read do |site|
  theme = site.data["theme"]
  cors = site.data.dig("origin", "cors")
  next unless theme.is_a?(Hash) && cors.is_a?(Hash)

  families = %w(font_body font_heading font_code)
    .map { |key| theme[key].to_s.strip }
    .reject(&:empty?)
    .uniq
  next if families.empty?

  query = families.map { |name| "family=#{name.tr(' ', '+')}:wght@400;700" }.join("&")
  cors["webfonts"] = "https://fonts.googleapis.com/css2?#{query}&display=swap"
end
