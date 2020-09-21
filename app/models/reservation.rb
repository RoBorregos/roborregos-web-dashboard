class Reservation < ApplicationRecord
  alias_attribute :rdetail,  :reservation_detail
  alias_attribute :rdetails, :reservation_details

  validates :member,
            presence: true

  belongs_to :member
  has_many   :reservation_details
end
