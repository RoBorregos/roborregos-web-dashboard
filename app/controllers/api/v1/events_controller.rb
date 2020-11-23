class Api::V1::EventsController < Api::V1::BaseController
  def index
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: Event.all};
  end

  def show
    if Event.where(id: params[:id]).empty?
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    else
      @status = 200
      @message = t('messages.success_request')
      @data = Event.find(params[:id])
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def create
    @event = Event.new(name: params[:name], start_date: params[:start_date], end_date: params[:end_date], description: params[:description], image: params[:image], sponsor_id: params[:sponsor_id])
    
    if @event.save
      @status = 200
      @message = t('messages.success_request')
      @data = @event
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @event.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def destroy
    @status = 400
    @message = t('messages.failed_request')
    @data = nil
    
    if Event.exists?(id:params[:id])
      Event.find(params[:id]).destroy
      @status = 200
      @message = t('messages.success_request')
    end
    
    render json: {status:@status, message: @message,data: @data}
  end
  
end
