class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    @status = 200
    @message = t('messages.success_request')
    render json: {status:@status, message: @message,data: Project.all};
  end

  def show
    if Project.where(id: params[:id]).empty?
      @status = 400
      @message = t('messages.failed_request')
      @data = nil
    else
      @status = 200
      @message = t('messages.success_request')
      @data = Project.find(params[:id])
    end
    render json: {status:@status, message: @message,data: @data};
  end

  def create
    @project = Project.new(name: params[:name], description: params[:description], image: params[:image], url: params[:url])
    
    if @project.save
      @status = 200
      @message = t('messages.success_request')
      @data = @project
    else
      @status = 400
      @message = t('messages.failed_request') + " - " + @project.errors.full_messages.join(', ')
      @data = nil
    end
    render json: {status:@status, message: @message,data: @data};
  end
  
  def destroy
    @status = 400
    @message = t('messages.failed_request')
    @data = nil
    
    if Project.exists?(id:params[:id])
      Project.find(params[:id]).destroy
      @status = 200
      @message = t('messages.success_request')
    end
    
    render json: {status:@status, message: @message,data: @data}
  end

end
