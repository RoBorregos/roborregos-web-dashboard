class ReservationDetail < ApplicationRecord
  validates :reservation,
            :component,
            presence: true

  belongs_to :reservation
  belongs_to :component
end
