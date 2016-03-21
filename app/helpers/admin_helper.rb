module AdminHelper

  def admin_nav_hidden?
    controller_name.ends_with?("admin")
  end

  def admin_nav_links
    AdminNavLinks.for_role(current_role.name)
  end

  def admin_section_available? name
    name = name.parameterize.underscore
    Feature::NAMES.exclude?(name) || feature_active?(name)
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

    link_to fa_icon(icon), nil, delete_link_options(*parents, resource, name)
  end

  def delete_link_options *parents, resource, name
    options = { method: :delete, remote: true }

    if resource == @site.home_page || resource == @site.splash_page
      options[:href] = "javascript:void(0)"
      options[:data] = { toggle: "tooltip", placement: "left", container: "body" }
      options[:title] = "This page cannot be deleted because it is set as the home page or the splash page."
      options[:class] = "disabled"
    else
      options[:href] = polymorphic_path([:admin, *parents, resource])
      options[:data] = { confirm: "Are you sure you want to delete this #{name}?" }
    end

    options
  end

  def code_font_link_tag
    stylesheet_link_tag("https://fonts.googleapis.com/css?family=Inconsolata", media: "all")
  end

  def ckeditor_script_tag
    javascript_include_tag("//cdn.ckeditor.com/4.5.1/full/ckeditor.js")
  end

  def ace_editor_script_tag
    javascript_include_tag("//cdn.jsdelivr.net/ace/1.2.0/min/ace.js")
  end

  def form_title resource, name = nil
    name ||= resource.class.to_s.titleize
    resource.new_record? ? "Add #{name}" : "Edit #{name}"
  end

  def info_box text
    content_tag(:div, class: "info-box") do
      fa_icon("exclamation-circle") + text.html_safe
    end
  end

  def info_tooltip text, placement = "right"
    fa_icon("info-circle", data: { toggle: "tooltip", placement: placement }, title: text)
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

  def snippet_target snippet
    case snippet.extension
    when "css", "scss" then "scss-editor"
    when "js"          then "javascript-editor"
    end
  end

  def grouped_page_options_for_select selected_page_id, page_scope = {}
    page_scope.reverse_merge!(published: true)

    custom_pages = CustomPage.where(page_scope)
    default_pages = DefaultPage.with_active_feature.where(page_scope)

    grouped_pages = {}
    grouped_pages["Custom Pages"] = page_option_value_pairs(custom_pages) if custom_pages.any?
    grouped_pages["Default Pages"] = page_option_value_pairs(default_pages) if default_pages.any?

    grouped_options_for_select(grouped_pages, selected_page_id)
  end

  def page_option_value_pairs pages
    pages.map { |page| [page.title, page.id] }
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