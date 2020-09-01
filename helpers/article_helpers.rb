module ArticleHelpers
  def process_article_body(html)
    fragment = Nokogiri::HTML::DocumentFragment.parse(html)

    # Wrap images’ paragraphs in figures

    fragment.css("img").each do |image|
      if image.parent.parent.name != "figure"
        image.parent.wrap("<figure>")
      end
    end

    # Group adjacent figures

    fragment.css("figure").each do |figure|
      if figure.at_xpath('preceding-sibling::node()[not(self::text()[not(normalize-space())])][1][self::div]')
        figure.previous_element << figure
      else
        figure.replace("<div class='d-article-figure-group'>").first << figure
      end
    end

    # Make figures wide if they have captions

    fragment.css(".d-article-figure-group").each do |group|
      if group.css("img").all? { |image| has_a_title(image) }
        group.add_class("d-wide")
      end
    end

    # Make images responsive

    fragment.css("img").each do |image|
      image.replace(image_partial(image))
    end

    fragment.to_html
  end

  private

  def has_a_title(element)
    element.attribute("title") != nil
  end

  def contains_single_image(element)
    element.children.count == 1 && element.children.first.name == "img"
  end

  def image_partial(image)
    partial(:image, locals: { src: image.attribute("src"), alt: image.attribute("alt") })
  end
end
