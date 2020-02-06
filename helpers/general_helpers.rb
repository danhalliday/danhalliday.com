require "json"

module GeneralHelpers
  def page_title
    title = yield_content(:title) || current_page.data.title
    components = title ? [title, data.site.name] : [data.site.name, data.site.tagline]
    components.join(data.site.separator.center(3))
  end

  def page_description
    yield_content(:description) || current_page.data.description || data.site.description
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
end
