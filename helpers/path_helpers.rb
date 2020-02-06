module PathHelpers
  def feed_url
    URI::join(data.site.url, "feed.xml")
  end

  def sitemap_url
    URI::join(data.site.url, "sitemap.xml")
  end
end
