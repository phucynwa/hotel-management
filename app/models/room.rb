class Room < ApplicationRecord
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :booking_details
  has_many :bookings, through: :booking_details
  accepts_nested_attributes_for :images, update_only: true

  validates :label, :floor, :status, presence: true
end
