module AdminHelper

  def ckeditor_script_tag
    content_tag(:script, nil, src: "//cdn.ckeditor.com/4.5.1/standard/ckeditor.js")
  end

  def grouped_page_options_for_select selected_page_id = nil
    grouped_pages = {
      "Custom Pages" => Page.published.map { |page| [page.title, page.id] },
      "Default Pages" => Page.uneditable.map { |page| [page.title, page.id] }
    }

    grouped_options_for_select(grouped_pages, selected_page_id)
  end

  def file_btn checked = false, text = "Choose File"
    btn_classes = ["file-btn", "btn-white"]
    btn_classes << "checked" if checked

    content_tag(:button, type: "button", class: btn_classes.join(" ")) do
      text.html_safe + fa_icon("check")
    end
  end

  def submit_btn text = "Save"
    content_tag(:button, type: "submit", class: "btn-blue submit-btn") do
      text.html_safe + fa_icon("spinner spin")
    end
  end

end