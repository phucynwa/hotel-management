class Category < ApplicationRecord
  VALID_PRICE_REGEX = /(\d)(?=(\d{3})+(?!\d))/
  before_destroy :check_category
  has_many :rooms, dependent: :destroy
  scope :by_latest, ->{order created_at: :desc}
  validates :name, :price, :description, presence: true
  validates :name, length: {maximum: Settings.name_category_maximum}
  validates :price, format: {with: VALID_PRICE_REGEX}
  validates :description, length: {minimum: Settings.description_minimum}

  def check_category
    return if self.rooms.empty?
    errors[:base] << I18n.t("admin.categories.warning")
    throw :abort
  end
end
