class Admin::ShowsController < Admin::AdminController
  respond_to :js

  def index
    @shows = Show.order(:date)
  end

  def new
    @show = Show.new
  end

  def create
    params[:show][:date] = format_date(params[:date])
    @show = Show.new(show_params)
    if @show.save
      @shows = Show.order(:date)
      flash.now[:notice] = "Show successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
    @show = Show.find(params[:id])
  end

  def update
    @show = Show.find(params[:id])
    params[:show][:date] = format_date(params[:date])
    if @show.update_attributes(show_params)
      @shows = Show.order(:date)
      flash.now[:notice] = "Show successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy
    @shows = Show.order(:date)
    flash.now[:notice] = "Show successfully deleted."
  end

  private

  def show_params
    params.require(:show).permit(:venue, :date, :time, :cover, :address, :city, :state, :zip, :notes)
  end

  def format_date date
    return nil if date.blank?
    date = date.split("-")
    date[0], date[1] = date[1], date[0]
    date.join("-").to_datetime
  end

end