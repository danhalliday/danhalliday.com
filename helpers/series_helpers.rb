module SeriesHelpers
  def series_description(series)
    Kramdown::Document.new(data.series[series].description).to_html.html_safe
  end
end
