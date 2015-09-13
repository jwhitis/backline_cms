module ShowsHelper

  def formatted_show_date show
    show.date.to_s(:short).gsub(" ", "&nbsp").html_safe
  end

  def venue_link show
    link_to_if show.venue_url.present?, show.venue_name, show.venue_url, target: "_blank"
  end

  def google_maps_link show
    return "" if show.address.blank?

    query = "#{show.address}, #{show.city}, #{show.state} #{show.zip}".to_query("q")
    link_to fa_icon("map-marker"), "https://maps.google.com?#{query}", target: "_blank",
      class: "google-maps-link"
  end

end