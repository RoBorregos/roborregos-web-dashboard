class ReservationDetail < ApplicationRecord
  validates :reservation,
            :component,
            :status,
            presence: true

  belongs_to :reservation
  belongs_to :component

  enum status: {
    requested: 1,
    delivered: 2,
    returned: 3,
    received: 4,
    cancelled: 5
  }

end
