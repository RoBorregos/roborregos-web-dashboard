class ComponentCategory < ApplicationRecord
  validates :name,
            presence: true

  has_many :components
end
