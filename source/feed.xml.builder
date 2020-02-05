xml.instruct! :xml, :version => "1.0"

rss_attributes = {
  "version" => "2.0",
  "xmlns:atom" => "http://www.w3.org/2005/Atom"
}

xml.rss rss_attributes do
  xml.channel do
    xml.title data.feed.title
    xml.description data.feed.description
    xml.link feed_url

    blog.articles.each do |work|
      xml.item do
        xml.title work_title(work)
        xml.description work.data.summary
        xml.pubDate work.date.to_s(:rfc822)
        xml.link work_url(work)
        xml.guid work_url(work)
      end
    end
  end
end
