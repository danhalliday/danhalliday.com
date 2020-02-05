xml.instruct!

xml.feed xmlns: "http://www.w3.org/2005/Atom" do
  xml.title data.feed.title
  xml.subtitle data.feed.subtitle
  xml.id feed_url
  xml.link href: data.site.url, rel: :self
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name data.site.name }

  blog.articles.each do |article|
    xml.entry do
      xml.id work_url(article)
      xml.title work_title(article)
      xml.link rel: :alternate, href: work_url(article)
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name data.site.name }
      xml.summary article.data.summary, type: :text
      xml.content article.data.summary, type: :text
    end
  end
end
