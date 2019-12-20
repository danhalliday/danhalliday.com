ignore "*.sketch*"

set :slim, { pretty: !build?, disable_escape: false }
set :markdown, { smartypants: true, header_offset: 1 }

# Extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :livereload
activate :dato, live_reload: true

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :blog do |blog|
  blog.layout = :project
  blog.prefix = "projects"
  blog.sources = "{slug}.html"
  blog.permalink = "{slug}.html"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Proxies
# https://middlemanapp.com/advanced/dynamic-pages/

# data.projects.each do |project|
#   proxy project_path(project), "project.html", ignore: true, locals: { project: project }
# end

proxy "_headers", "netlify/headers.txt", ignore: true
proxy "_redirects", "netlify/redirects.txt", ignore: true

# Build
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
end
