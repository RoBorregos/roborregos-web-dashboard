class Api::V1::ComponentsController < Api::V1::BaseController
  def index
    
    @components = Component.all

    render json: @components
  end

  def show
    @component = Component.find(params[:id])
    
    render json: @component
  end

end
