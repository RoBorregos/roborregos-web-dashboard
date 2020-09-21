class Component < ApplicationRecord
  alias_attribute :ccategory, :component_category
  alias_attribute :ccategories, :component_categories

  validates :name,
            :component_category,
            :img_path,
            presence: true

  belongs_to :component_category
  has_many   :reservation_details
end
