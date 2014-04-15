module Admin::AdminHelper

  def published_state model
    model.published ? "on" : "off"
  end

end
