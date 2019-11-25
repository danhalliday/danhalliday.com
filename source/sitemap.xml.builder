xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap_resources.each do |page|
    xml.url do
      path = page.destination_path.chomp("index.html").chomp(".html")
      modified = page.data.date ? page.data.date.to_time : Time.now

      xml.loc URI.join(data.site.url, path)
      xml.lastmod modified.iso8601
      xml.changefreq page.data.changefreq || "monthly"
      xml.priority page.data.priority || "0.5"
    end
  end
end
