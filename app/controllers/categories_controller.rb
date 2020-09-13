class CategoriesController < BaseController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      flash[:error] = t('messages.errors.could_not_save_member')
      redirect_to new_category_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(
      :name,
      :description,
      :reference_url
    )
  end
end
