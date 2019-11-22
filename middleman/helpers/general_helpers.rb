require "json"

module GeneralHelpers
  def page_title
    custom_title = yield_content(:title) || current_page.data.title
    (custom_title ? [custom_title, data.site.name] : [data.site.name, data.site.tagline]).join(data.site.separator.center(3))
  end

  def page_description
    current_page.data.description || data.site.description
  end

  def page_id_class
    "d-page-#{current_page.page_id}"
  end

  def sitemap_url
    URI::join(data.site.url, "sitemap.xml")
  end

  def sitemap_resources
    sitemap.resources.select do |page|
      page.destination_path =~ /\.html/ && page.data.noindex != true
    end
  end

  def schema(file, locals = nil)
    output = partial(file, locals: locals)
    minfied = JSON.generate(JSON.parse(output))
    "<script type='application/ld+json'>#{minfied}</script>".html_safe
  end

  def work
    current_article
  end

  def work_title
    "#{work.title} for #{work.data.client}"
  end

  def image_src(src)
    "#{src}?w=1000&auto=format&q=50"
  end

  def image_srcset(src)
    (300..5100).step(300).map { |s| "#{src}?w=#{s}&auto=format&q=25 #{s}w" }.join(", ")
  end

  def process_work_body(body)
    body
  end
end
