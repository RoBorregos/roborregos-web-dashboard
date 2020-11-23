class Api::V1::SponsorsController < Api::V1::BaseController
  def index
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: Sponsor.all};
  end

  def show
    if Sponsor.where(id: params[:id]).empty?
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    else
      @status = 200
      @message = t('messages.success_request')
      @data = Sponsor.find(params[:id])
    end
    render json: {status:@status, message: @message,data: @data};
  end
  
  def create
    @sponsor = Sponsor.new(name: params[:name], description: params[:description], avatar: params[:avatar], website_url: params[:website_url])
    
    if @sponsor.save
      @status = 200
      @message = t('messages.success_request')
      @data = @sponsor
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @sponsor.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def destroy
    @status = 400
    @message = t('messages.failed_request')
    @data = nil
    
    if Sponsor.exists?(id:params[:id])
      Sponsor.find(params[:id]).destroy
      @status = 200
      @message = t('messages.success_request')
    end
    
    render json: {status:@status, message: @message,data: @data}
  end

end
