class Api::V1::ComponentCategoriesController < Api::V1::BaseController
  def index
    
    @component_categories = ComponentCategory.all

    render json: @component_categories
  end

  def show
    @component_category = ComponentCategory.find(params[:id])
    
    render json: @component_category
  end

end
