class SubscribersController < ApplicationController
  before_action :verify_feature_activated!
  before_action :find_page, only: :new
  before_action :find_or_initialize_subscriber, only: [:create, :newsletter]
  feature_name :mailing_list

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber.validate_profile = true
    @subscriber.assign_attributes(subscriber_params) unless @subscriber.valid?

    if !@subscriber.changed? || @subscriber.save
      store_subscriber_id!
      redirect_to after_subscription_path, notice: "You now have access to exclusive content."
    else
      flash.now[:alert] = "Please fill in all of the required fields."
      render :new
    end
  end

  def newsletter
    if @subscriber.persisted? || @subscriber.save
      flash.now[:notice] = "You've been added to our mailing list."
    else
      flash.now[:alert] = "Please enter your email address and try again."
    end
  end

  private

  def find_or_initialize_subscriber
    @subscriber = Subscriber.find_or_initialize_by(email: subscriber_email)
  end

  def subscriber_email
    params[:subscriber][:email]
  end

  def store_subscriber_id!
    cookies.permanent.signed[:subscriber_id] = @subscriber.id
  end

  def after_subscription_path
    return home_page_path if request_path.blank?

    request_path.end_with?("/download") ? albums_path : request_path
  end

  def request_path
    params[:request_path]
  end

  def subscriber_params
    params.require(:subscriber).permit(:email, :first_name, :last_name, :country, :zip)
  end

end