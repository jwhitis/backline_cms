class Admin::ShowsController < ApplicationController

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
      redirect_to admin_shows_path, notice: "Show successfully created."
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
      redirect_to admin_shows_path, notice: "Show successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy
    redirect_to admin_shows_path, notice: "Show successfully deleted."
  end

  private

  def show_params
    params.require(:show).permit(:venue, :date, :time, :cover, :address, :city, :state, :zip, :notes)
  end

  def format_date date
    date = date.split("-")
    date[0], date[1] = date[1], date[0]
    date.join("-").to_datetime
  end

end
