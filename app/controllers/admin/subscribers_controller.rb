class Admin::SubscribersController < Admin::AdminController
  before_action :verify_feature_activated!
  before_action :find_subscriber, only: [:edit, :update, :destroy]

  def index
    @subscribers = Subscriber.display_order.page(params[:page])

    respond_to do |format|
      format.js
      format.csv { send_data @subscribers.to_csv, filename: filename }
    end
  end

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      @subscribers = Subscriber.display_order.page(params[:page])
      flash.now[:notice] = "Subscriber successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subscriber.update_attributes(subscriber_params)
      @subscribers = Subscriber.display_order.page(params[:page])
      flash.now[:notice] = "Subscriber successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @subscriber.destroy
    @subscribers = Subscriber.display_order.page(params[:page])
    flash.now[:notice] = "Subscriber successfully deleted."
    render :index
  end

  private

  def filename
    "subscribers_#{timestamp}.csv"
  end

  def timestamp
    Time.now.strftime("%Y%m%d")
  end

  def find_subscriber
    @subscriber = Subscriber.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:email, :first_name, :last_name, :country, :zip)
  end

  def feature_name
    :mailing_list
  end

end