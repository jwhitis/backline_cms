class Admin::ShowsController < Admin::AdminController
  before_action :find_show, only: [:edit, :update, :destroy]

  def index
    @shows = Show.display_order.page(params[:page])
  end

  def new
    @show = Show.new
  end

  def create
    @show = Show.new(show_params)

    if @show.save
      @shows = Show.display_order.page(params[:page])
      flash.now[:notice] = "Show successfully created."
      render :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @show.update_attributes(show_params)
      @shows = Show.display_order.page(params[:page])
      flash.now[:notice] = "Show successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @show.destroy
    @shows = Show.display_order.page(params[:page])
    flash.now[:notice] = "Show successfully deleted."
    render :index
  end

  private

  def find_show
    @show = Show.find(params[:id])
  end

  def show_params
    params.require(:show).permit(:venue_name, :venue_url, :date, :time, :cover,
      :address, :city, :state, :zip, :notes, :published)
  end

end