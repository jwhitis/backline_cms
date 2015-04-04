module PagesHelper

  def venue_link show
    return show.venue_name if show.venue_url.blank?

    # In order for the link to open properly, the venue URL must contain the protocol.
    link_to show.venue_name, show.venue_url, target: "_blank"
  end

  def google_maps_link show
    return nil if show.address.blank?

    query = "#{show.address}, #{show.city}, #{show.state} #{show.zip}".to_query("q")
    link_to fa_icon("map-marker"), "https://maps.google.com?#{query}", target: "_blank",
      class: "google-maps-link"
  end

  def photo_title photo
    "<div class=\"photo-caption\">#{photo.caption}</div>"
  end

end
