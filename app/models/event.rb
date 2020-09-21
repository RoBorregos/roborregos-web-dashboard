class Event < ApplicationRecord
  validates :name,
            :end_date,
            :start_date,
            presence: true

  belongs_to :sponsor, optional: true

  has_many :event_members
  has_many :members, through: :event_members

  def sponsor_name
    self.sponsor&.name
  end

end
