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

  def project_path(project)
    "/projects/#{project.id}.html"
  end

  def project_page_title(project)
    "#{project.title} for #{project.client}"
  end

  def work
    current_article
  end

  def work_title
    "#{work.title} for #{work.data.client}"
  end
end
