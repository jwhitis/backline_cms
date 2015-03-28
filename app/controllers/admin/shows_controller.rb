class Admin::ShowsController < Admin::AdminController
  respond_to :js

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
    @show = Show.find(params[:id])
  end

  def update
    @show = Show.find(params[:id])

    if @show.update_attributes(show_params)
      @shows = Show.display_order.page(params[:page])
      flash.now[:notice] = "Show successfully updated."
      render :index
    else
      render :edit
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy
    @shows = Show.display_order.page(params[:page])
    flash.now[:notice] = "Show successfully deleted."
    render :index
  end

  private

  def show_params
    params.require(:show).permit(:venue_name, :venue_url, :date, :time, :cover,
      :address, :city, :state, :zip, :notes, :published)
  end

end