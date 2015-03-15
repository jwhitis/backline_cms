module PagesHelper

  def formatted_show_date show
    show.date.strftime("%b %d")
  end

  def venue_link show
    return show.venue_name if show.venue_url.blank?

    link_to show.venue_name, show.venue_url, target: "_blank"
  end

  def formatted_show_location show
    "#{show.city}, #{show.state}"
  end

  def google_maps_link show
    return nil if show.address.blank?

    query = "#{show.address}, #{show.city}, #{show.state} #{show.zip}".to_query("q")
    link_to fa_icon("map-marker"), "https://maps.google.com?#{query}", target: "_blank",
      class: "google-maps-link"
  end

end
