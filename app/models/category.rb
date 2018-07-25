class Category < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :name, :price, :description, presence: true
end
