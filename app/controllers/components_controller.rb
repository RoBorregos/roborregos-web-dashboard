class ComponentsController < BaseController
  def index
    dateReservationValidation
    @components = Component.all
  end

  def show
    @component = Component.find(params[:id])
  end

  def new
    @component = Component.new
  end

  def create
    begin
      @uuidComponent = SecureRandom.uuid
    end while Component.exists?(uuid: @uuidComponent)

    @component = Component.new(component_params)
    @component.uuid = @uuidComponent

    if @component.save
      redirect_to @component
    else
      flash[:error] = t('messages.errors.could_not_save_component')
      redirect_to new_component_url
    end
  end

  def edit
    @component = Component.find(params[:id])
  end

  def update
    @component = Component.find(params[:id])

    if @component.update(component_params)
      redirect_to @component
    else
      flash[:error] = t('messages.errors.could_not_save_component')
      redirect_to edit_component_path
    end
  end

  def destroy
    @component = Component.find(params[:id])
    @component.destroy

    redirect_to components_path
  end

  private

  def component_params
    params.require(:component).permit(
      :name,
      :component_category_id,
      :img_path,
      :stock
    )
  end

  def dateReservationValidation
    @reservationsDetails = ReservationDetail.where("status = 1 AND created_at <= :date",{date: (Time.now.midnight - 2.day)})
    @reservationsDetails.update_all(uuid: "",status: 5)
  end
end
