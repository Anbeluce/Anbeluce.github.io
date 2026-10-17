#!/usr/bin/env ruby
#
# Drop any post marked `draft: true` in its front matter from the posts
# collection, the same way Jekyll's own `published: false` would.
#
# `published: false` can't be set from a post_init hook: Jekyll checks
# document.published? right after Document#read, inside Collection#read_document,
# with no hook in between — post_init itself fires before front matter is even
# parsed. Instead, drop the doc from the (shared, mutable) collection array in
# :site, :post_read, which runs after reading but before generate/render/write,
# so the post never gets a page, and disappears from pagination, archives,
# categories/tags, the sitemap and the RSS feed, same as published: false.

Jekyll::Hooks.register :site, :post_read do |site|
  site.collections["posts"].docs.reject! { |doc| doc.data["draft"] }
end
