module PathHelpers
  def feed_url
    URI::join(data.site.url, "feed.xml")
  end

  def sitemap_url
    URI::join(data.site.url, "sitemap.xml")
  end

  def page_url(page)
    URI::join(data.site.url, page.url.chomp(".html"))
  end
end
