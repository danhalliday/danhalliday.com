require "base64"

module AssetHelpers
  def image_src(src)
    "#{src}?w=1000&auto=format&q=50"
  end

  def image_sharing_src(src)
    "#{src}?w=1500&auto=format&q=80"
  end

  def image_srcset(src)
    (300..5100).step(300).map { |s| "#{src}?w=#{s}&auto=format&q=25 #{s}w" }.join(", ")
  end

  def svg_optimized(file)
    SvgOptimizer.new.optimize(File.read("source/images/#{file}"))["data"]
  end

  def svg_data_uri(file)
    "data:image/svg+xml;base64,#{Base64.strict_encode64(svg_optimized(file))}"
  end

  def javascript_inline_tag(file)
    js = File.read("source/javascripts/#{file.to_s}")
    "<script>#{Uglifier.new.compile(js)}</script>".html_safe
  end
end
