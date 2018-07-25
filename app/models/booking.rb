class Booking < ApplicationRecord
  belongs_to :user
  has_one :bill
  has_many :booking_details
  has_many :rooms, through: :booking_details

  validates :start_time, :end_time, presence: true
end
