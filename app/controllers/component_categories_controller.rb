class ComponentCategoriesController < BaseController
  def index
    @component_categories = ComponentCategory.all
  end

  def show
    @component_category = ComponentCategory.find(params[:id])
  end

  def new
    @component_category = ComponentCategory.new
  end

  def create
    @component_category = ComponentCategory.new(component_category_params)

    if @component_category.save
      redirect_to @component_category
    else
      flash[:error] = t('messages.errors.could_not_save_component_category')
      redirect_to new_component_category_url
    end
  end

  def edit
    @component_category = ComponentCategory.find(params[:id])
  end

  def update
    @component_category = ComponentCategory.find(params[:id])

    if @component_category.update(component_category_params)
      redirect_to @component_category
    else
      flash[:error] = t('messages.errors.could_not_save_category')
      redirect_to edit_component_category_path
    end
  end

  def destroy
    @component_category = ComponentCategory.find(params[:id])
    @component_category.destroy

    redirect_to component_categorys_path
  end

  private

  def component_category_params
    params.require(:component_category).permit(
      :name,
      :description
    )
  end
end
