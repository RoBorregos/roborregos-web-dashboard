class Api::V1::ComponentCategoriesController < Api::V1::BaseController
  def index
    @data = ComponentCategory.all
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: @data}
  end

  def show
    if ComponentCategory.exists?(id:params[:id])
      @data = ComponentCategory.find(params[:id])
    else
      @data = nil
    end
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: @data}
  end

  def create
    @componentCategory = ComponentCategory.new(name: params[:name], description: params[:description])
    if @componentCategory.save
      @data = @componentCategory
      @status = 200
      @message = t('messages.success_request')
    else
      @data = nil
      @status = 400
      @message = t('messages.failed_request')
    end
    render json: {status:@status, message: @message,data: @data}
  end

  def destroy
    if ComponentCategory.exists?(id:params[:id])
      ComponentCategory.find(params[:id]).destroy
    end
    @status = 200
    @message = t('messages.success_request')
    @data = nil
    render json: {status:@status, message: @message,data: @data}
    
  end
end
