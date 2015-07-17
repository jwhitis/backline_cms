class SubscribersController < ApplicationController

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.create_with(subscriber_params).
                             find_or_initialize_by(email: subscriber_email)

    if @subscriber.persisted? || @subscriber.save
      store_subscriber_email!
      flash[:notice] = "<strong>THANK YOU</strong><br />You now have access to free content."
      redirect_to after_subscription_path
    else
      render :new
    end
  end

  private

  def subscriber_email
    params[:subscriber][:email]
  end

  def store_subscriber_email!
    session[:subscriber_email] = @subscriber.email
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

end