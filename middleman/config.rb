ignore "*.sketch*"

set :slim, { pretty: !build?, disable_escape: false }

# Extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :livereload

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Proxies
# https://middlemanapp.com/advanced/dynamic-pages/

proxy "_headers", "netlify/headers.txt", ignore: true
proxy "_redirects", "netlify/redirects.txt", ignore: true

# Build
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
end
