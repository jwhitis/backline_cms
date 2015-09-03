module AdminHelper

  def admin_nav_hidden?
    %w(admin sessions).include?(controller_name)
  end

  def admin_nav_links
    [
      ["Pages", admin_pages_path, "file"],
      ["Nav", admin_nav_links_path, "list"],
      ["Shows", admin_shows_path, "ticket"],
      ["Albums", admin_albums_path, "dot-circle-o"],
      ["Photos", admin_photos_path, "camera"],
      ["Videos", admin_videos_path, "video-camera"],
      ["Audio", admin_player_tracks_path, "music"],
      ["Twitter", admin_twitter_handles_path, "twitter"],
      ["Users", admin_subscribers_path, "users"]
    ]
  end

  def corner_btn text, url, html_options = {}
    options = { remote: true, class: "corner-btn btn-blue" }
    options[:class].sub!("btn-blue", html_options.delete(:class)) if html_options[:class]
    options.merge!(html_options)

    link_to(text, url, options)
  end

  def ckeditor_script_tag
    content_tag(:script, nil, src: "//cdn.ckeditor.com/4.5.1/full/ckeditor.js")
  end

  def ace_editor_script_tag
    content_tag(:script, nil, src: "//cdn.jsdelivr.net/ace/1.2.0/min/ace.js")
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

  def submit_btn text = "Save", html_options = {}
    options = { type: "submit", name: "commit", value: text, class: "submit-btn btn-blue" }
    options[:class].sub!("btn-blue", html_options.delete(:class)) if html_options[:class]
    options.merge!(html_options)

    content_tag(:button, options) do
      text.html_safe + fa_icon("spinner spin")
    end
  end

end