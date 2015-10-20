module DesignsHelper

  def extension_tags resource, attribute
    extensions = resource.send(attribute).extension_white_list

    content_tag(:div, class: "extensions") do
      extensions.reduce("".html_safe) do |tags, extension|
        tags + content_tag(:span, extension.upcase)
      end
    end
  end

  def dimensions_tag width, height
    unit_tag = content_tag(:small, "px")

    content_tag(:span, class: "dimensions") do
      "#{width}#{unit_tag} : #{height}#{unit_tag}".html_safe
    end
  end

end