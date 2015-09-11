class Admin::ConfigurationsController < Admin::AdminController
  before_action :find_configuration, only: [:edit, :update]

  def edit
  end

  def update
    if @configuration.update_attributes(configuration_params)
      Backline.reload
      redirect_to admin_root_path, notice: "Settings successfully updated."
    else
      render :edit
    end
  end

  private

  def find_configuration
    @configuration = Backline.configuration
  end

  def configuration_params
    params.require(:configuration).permit(:homepage_id)
  end

end