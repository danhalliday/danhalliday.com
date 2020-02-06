module ProjectHelpers
  def project
    current_article
  end

  def project_title(project)
    "#{project.title} for #{project.data.client}"
  end

  def project_path(project)
    project.data.url || project.path
  end

  def project_url(project)
    URI::join(data.site.url, project_path(project).chomp(".html"))
  end
end
