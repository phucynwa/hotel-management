class Room < ApplicationRecord
  enum status: {free: 0, booked: 1, used: 2, maintenance: 3}
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :booking_details
  has_many :bookings, through: :booking_details
  accepts_nested_attributes_for :images, update_only: true, allow_destroy: true

  validates :label, :floor, :status, presence: true
  validates :floor, numericality: {greater_than: Settings.zero}

  scope :by_category_id, ->(category_id){where category_id: category_id if category_id.present?}
  scope :by_floor, ->(floor){where floor: floor if floor.present?}
  scope :by_status, ->(status){where status: status}
  scope :not_maintenance, ->{where.not status: :maintenance}
end
