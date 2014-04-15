module Admin::ShowsHelper

  def show_title show
    title = "#{show.city}"
    title += ", " if show.city.present? && show.state.present?
    title += "#{show.state}"
    title += " - " if (show.city.present? || show.state.present?) && show.venue.present?
    title += "#{show.venue}"
  end

end
