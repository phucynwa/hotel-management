class Image < ApplicationRecord
  belongs_to :room

  validates :image_link, presence: true
end
