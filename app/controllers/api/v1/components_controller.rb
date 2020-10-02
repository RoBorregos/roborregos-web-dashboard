class Api::V1::ComponentsController < Api::V1::BaseController
  def index
    dateReservationValidation
    showAll
  end

  def show
    @data = nil
    if Component.exists?(id:params[:id])
      @data = Component.find(params[:id])
    end    
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: @data}
  end

  def create
    begin
      @uuidComponent = SecureRandom.uuid
    end while Component.exists?(uuid: @uuidComponent)
    
    @component = Component.new(name: params[:name], component_category_id: params[:category], img_path: params[:img_path], stock: params[:stock], uuid: @uuidComponent)
    
    if @component.save
      @status = 200
      @message = t('messages.success_request')
      @data = @component
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @component.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def update
    if params[:add].present? || params[:stock].present? 
      @component = Component.find(params[:id])
      if params[:stock].present?
        @component.stock = params[:stock] 
      end
      if params[:add].present? 
        @component.stock = @component.stock + params[:add] 
      end
      @component.save 
      @status = 200
      @message = t('messages.success_request')
      @data = @component
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def destroy
    if Component.exists?(id:params[:id])
      Component.find(params[:id]).destroy
    end
    @status = 200
    @message = t('messages.success_request')
    @data = nil
    render json: {status:@status, message: @message,data: @data}
  end

  private

  def showAll
    @componentCategories = ComponentCategory.all
    @categorieslist = @componentCategories.map { |category|
      if category.present?
        @components = Component.where(component_category: category).where("upper(name) LIKE upper('%#{params[:suffix]}%')")
        @componetsList = @components.map { |component|
            if component.present?
              " \"#{component.uuid}\": { \"id\": \"#{component.id}\", \"name\": \"#{component.name}\", \"stock\": #{component.get_available}, \"img_path\": \"#{component.img_path}\" }"
            else
              nil
            end
        }.join(', ')
        "\"#{category.name}\": { #{@componetsList} }"
      else
        nil
      end
    }.join(', ')
    if @member_token.present?
      @status = 200
      @message = t('messages.success_request')
      @data = " { #{@categorieslist} } "
    else
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    end
    render json: {status:@status, message: @message,data: ActiveSupport::JSON.decode(@data)};
  end
  
  def dateReservationValidation
    @reservationsDetails = ReservationDetail.where("status = 1 AND created_at <= :date",{date: (Time.now.midnight - 2.day)})
    @reservationsDetails.update_all(uuid: "",status: 5)
  end
end
