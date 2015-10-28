module DesignsHelper

  def extension_tags resource, attribute
    extensions = resource.send(attribute).extension_white_list

    content_tag(:div, class: "extensions") do
      extensions.map! { |extension| content_tag(:span, extension.upcase) }
      extensions.join.html_safe
    end
  end

  def dimensions_tag width, height
    unit_tag = content_tag(:small, "px")

    content_tag(:span, class: "dimensions") do
      "#{width}#{unit_tag} : #{height}#{unit_tag}".html_safe
    end
  end

  def theme_options_for_select selected_theme_title
    themes = Theme.hashes.map do |title, attributes|
      [title.titleize, title, { data: attributes }]
    end

    options_for_select(themes, selected_theme_title)
  end

end