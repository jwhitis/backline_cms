module AdminHelper

  def file_btn checked = false, text = "Choose File"
    btn_classes = ["btn-white", "file-btn"]
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