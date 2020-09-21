class ServiceAppsController < BaseController
  def index
    @service_apps = ServiceApp.all
  end

  def create
    @service_app = ServiceApp.new(service_app_params)

    if @service_app.save
      redirect_to service_apps_path
    else
      flash[:error] = t('messages.errors.cound_not_save_service_app')
      redirect_to service_apps_path
    end
  end

  def destroy
    @service_app.find(params[:id])
    @service_app.destroy

    redirect_to service_apps_path
  end

  private

  def service_app_params
    params.require(:service_app).permit(
      :name,
      :active,
      :access_api,
      :description,
    )
  end
end
