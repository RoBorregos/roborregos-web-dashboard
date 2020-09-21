module TeamsHelper
  def category_options
    Category.pluck(:name , :id)
  end
end
