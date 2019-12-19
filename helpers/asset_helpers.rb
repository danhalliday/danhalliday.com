require "base64"

module AssetHelpers
  def svg_inlined(file)
    xml = File.read("source/images/#{file}")
    build? ? (ImageOptim.new.optimize_image_data(xml) or throw "ImageOptim Failed") : xml
  end

  def svg_data_uri(file)
    "data:image/svg+xml;base64,#{Base64.strict_encode64(svg_inlined(file))}"
  end
end
