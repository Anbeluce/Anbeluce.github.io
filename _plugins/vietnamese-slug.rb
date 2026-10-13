#!/usr/bin/env ruby
#
# Pages CMS builds filenames from the title and transliterates "đ" as "dj"
# ("điện thoại" -> "djien-thoai"). Rewrite those words back to "d" in the post
# slug, which drives the URL (/posts/:title/). The file itself keeps its name.
#
# A word is only rewritten when the title really has the matching "đ" word,
# so genuine words such as "django" are left alone. An explicit `slug:` in the
# front matter always wins.

Jekyll::Hooks.register :site, :post_read do |site|
  site.posts.docs.each do |post|
    title = post.data["title"].to_s
    next unless title.match?(/[đĐ]/)

    file_slug = post.basename_without_ext.sub(/\A\d{4}-\d{2}-\d{2}-/, "")
    next unless post.data["slug"] == file_slug # slug was set by hand

    title_words = title
      .unicode_normalize(:nfd)
      .gsub(/\p{Mn}/, "")
      .tr("đĐ", "dD")
      .downcase
      .split(/[^a-z0-9]+/)

    fixed = file_slug.split("-").map do |word|
      candidate = word.sub(/\Adj/, "d")
      word.start_with?("dj") && title_words.include?(candidate) ? candidate : word
    end.join("-")

    post.data["slug"] = fixed unless fixed == file_slug
  end
end
