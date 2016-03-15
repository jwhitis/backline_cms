class SuperAdmin::SuperAdminController < ApplicationController
  skip_around_action :set_current_site_id
  skip_before_action :find_nav_links
  skip_before_action :find_tweets
  before_action :authenticate_user!
  before_action :authorize_user!
  authorized_roles :super_admin
  layout "super_admin"

  def index
  end

end