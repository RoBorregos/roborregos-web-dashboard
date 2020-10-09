module ComponentsHelper
  def component_category_options
    ComponentCategory.pluck(:name, :id)
  end
end
