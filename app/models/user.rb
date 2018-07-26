class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :bookings, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :ratings, dependent: :destroy

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX},
    length: {maximum: Settings.validates.email_maximum},
    presence: true, uniqueness: true
  validates :password, length: {minimum: Settings.validates.password_minimum},
    presence: true, allow_nil: true
  validates :name, length: {maximum: Settings.validates.name_maximum},
    presence: true
  validates :phone, presence: true

  before_save :downcase_email

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def current_user? user
    user == self
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: User.digest(remember_token)
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
