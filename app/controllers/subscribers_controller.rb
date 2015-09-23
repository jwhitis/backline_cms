class SubscribersController < ApplicationController
  before_action :verify_feature_activated!
  before_action :find_or_initialize_subscriber, only: [:create, :newsletter]

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber.validate_profile = true
    @subscriber.assign_attributes(subscriber_params) unless @subscriber.valid?

    if !@subscriber.changed? || @subscriber.save
      store_subscriber_id!
      flash[:notice] = "<strong>THANK YOU</strong><br />You now have access to free content."
      redirect_to after_subscription_path
    else
      flash.now[:alert] = "<strong>SORRY</strong><br />Please fill in all of the required fields."
      render :new
    end
  end

  def newsletter
    if @subscriber.persisted? || @subscriber.save
      flash.now[:notice] = "<strong>THANK YOU</strong><br />You've been added to our mailing list."
    else
      flash.now[:alert] = "<strong>SORRY</strong><br />Please enter your email address and try again."
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
    return root_path if request_path.blank?

    request_path.end_with?("/download") ? albums_path : request_path
  end

  def request_path
    params[:request_path]
  end

  def subscriber_params
    params.require(:subscriber).permit(:email, :first_name, :last_name, :country, :zip)
  end

  def feature_name
    "Users"
  end

end