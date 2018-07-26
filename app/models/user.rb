class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_secure_password

  validates :name, presence: true, length: {maximum: Settings.validates.name_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
    length: {maximum: Settings.validates.email_maximum}, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length:
    {minimum: Settings.validates.password_minimum}, allow_nil: true
  validates :phone, presence: true
end
