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
      ["Audio Player", admin_player_tracks_path, "music"],
      ["Twitter Feed", admin_twitter_handles_path, "twitter"],
      ["Mailing List", admin_subscribers_path, "envelope"],
      ["Design", edit_admin_design_path, "paint-brush"],
      ["Settings", edit_admin_site_path, "cog"]
    ]
  end

  def admin_section_available? name
    name = name.parameterize.underscore
    Feature::NAMES.exclude?(name) || feature_activated?(name)
  end

  def admin_nav_link_to text, url = nil, &block
    url = text if block_given?

    options = {}
    options[:remote] = true unless url == edit_admin_design_path
    options[:data] = { no_turbolink: true } if url == edit_admin_design_path

    if block_given?
      link_to url, options, &block
    else
      link_to text, url, options
    end
  end

  def corner_btn text, url, html_options = {}
    options = { remote: true, class: "corner-btn btn-blue" }
    options[:class].sub!("btn-blue", html_options.delete(:class)) if html_options[:class]
    options.merge!(html_options)

    link_to text, url, options
  end

  def edit_link *parents, resource
    options = {}
    options[:remote] = true unless resource.is_a?(CustomPage)
    options[:data] = { no_turbolink: true } if resource.is_a?(CustomPage)

    link_to fa_icon("edit"), polymorphic_path([:admin, *parents, resource], action: :edit),
      options
  end

  def delete_link *parents, resource, icon: nil, name: nil
    return "" if resource.is_a?(DefaultPage)

    icon ||= "trash-o"
    name ||= resource.class.to_s.titleize.downcase

    link_to fa_icon(icon), polymorphic_path([:admin, *parents, resource]), method: :delete,
      remote: true, data: { confirm: "Are you sure you want to delete this #{name}?" }
  end

  def ckeditor_script_tag
    content_tag(:script, nil, src: "//cdn.ckeditor.com/4.5.1/full/ckeditor.js")
  end

  def ace_editor_script_tag
    content_tag(:script, nil, src: "//cdn.jsdelivr.net/ace/1.2.0/min/ace.js")
  end

  def form_title resource, name = nil
    name ||= resource.class.to_s.titleize
    resource.new_record? ? "Add #{name}" : "Edit #{name}"
  end

  def snippets_heading extension
    case extension.to_s
    when "txt"  then "Text"
    when "html" then "HTML"
    when "css"  then "CSS"
    when "scss" then "SCSS"
    when "js"   then "JavaScript"
    end
  end

  def grouped_page_options_for_select selected_page_id = nil
    grouped_pages = {
      "Custom Pages" => CustomPage.published.map { |page| [page.title, page.id] },
      "Default Pages" => DefaultPage.accessible.map { |page| [page.title, page.id] }
    }

    grouped_options_for_select(grouped_pages, selected_page_id)
  end

  def info_box text
    content_tag(:div, class: "info-box") do
      fa_icon("exclamation-circle") + text.html_safe
    end
  end

  def file_btn checked = false, text = "Choose File"
    btn_classes = ["file-btn", "btn-white"]
    btn_classes << "checked" if checked

    content_tag(:button, type: "button", class: btn_classes.join(" ")) do
      text.html_safe + fa_icon("check")
    end
  end

  def file_box_text resource, attribute
    filename = resource.send(attribute).file.filename
    "Filename: #{filename}"
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