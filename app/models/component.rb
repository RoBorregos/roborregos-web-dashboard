class Component < ApplicationRecord
  alias_attribute :ccategory, :component_category

  validates :name,
            :component_category,
            :img_path,
            presence: true

  belongs_to :component_category
end