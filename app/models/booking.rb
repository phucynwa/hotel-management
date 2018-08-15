class Booking < ApplicationRecord
  enum status: {created: 0, accepted: 1, checked_in: 2, checked_out: 3}

  belongs_to :user
  has_one :bill
  has_many :booking_details
  has_many :rooms, through: :booking_details
  scope :by_latest, ->{order created_at: :desc}
  validates :start_time, :end_time, presence: true
end
