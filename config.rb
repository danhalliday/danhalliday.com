proxy "/googlecfca002f899d9032.html", "/verify.html", { layout: nil, ignore: true, }

ignore '*.psd'
ignore '*.sketch'
ignore '*.nef'

ignore 'images/screenshots/*'

activate :autoprefixer

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

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

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css, inline: true
  activate :minify_javascript, inline: true
  activate :asset_hash
  activate :relative_assets
  activate :gzip

  activate :minify_html do |html|
    html.remove_intertag_spaces = true
  end
end
