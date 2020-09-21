class Team < ApplicationRecord
  validates :name,
            :category,
            presence: true

  belongs_to :category

  has_many :achievements
  has_many :team_members
  has_many :members, through: :team_members

  def category_name
    self.category.name
  end
end
