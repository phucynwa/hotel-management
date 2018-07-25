class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :name, :phone, :email, presence: true
end
