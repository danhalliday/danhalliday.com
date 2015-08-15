###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

proxy "/googlecfca002f899d9032.html", "/verify.html", { layout: nil }

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

ignore '*.psd'
ignore '*.sketch'
ignore '*.nef'

ignore 'images/screenshots/*'

###
# Helpers
###

activate :autoprefixer

activate :sync do |sync|
  Fog.credentials = { :path_style => true }
  sync.fog_provider = 'AWS'
  sync.fog_directory = 'danhalliday.com'
  sync.fog_region = 'eu-west-1'
  sync.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  sync.aws_secret_access_key = ENV['AWS_ACCESS_KEY_SECRET_ID']
  sync.existing_remote_files = 'delete'
  sync.gzip_compression = true
  sync.after_build = false
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Build-specific configuration
configure :build do
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :gzip

  activate :minify_html do |html|
    html.remove_intertag_spaces = true
  end

  activate :asset_hash
  activate :relative_assets
end
