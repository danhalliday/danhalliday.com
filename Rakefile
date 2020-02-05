task test: :build
task default: :serve

task :serve do
  system "bundle exec middleman server" or throw "Server Error"
end

task :build do
  system "bundle exec middleman build -e production --verbose" or throw "Build Error"
end
