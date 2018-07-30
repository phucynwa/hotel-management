class Category < ApplicationRecord
  VALID_PRICE_REGEX = /(\d)(?=(\d{3})+(?!\d))/

  has_many :rooms, dependent: :destroy

  validates :name, :price, :description, presence: true
  validates :name, length: {maximum: Settings.name_category_maximum}
  validates :price, format: {with: VALID_PRICE_REGEX}
  validates :description, length: {minimum: Settings.description_minimum}
end
