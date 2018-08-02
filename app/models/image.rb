class Image < ApplicationRecord
  belongs_to :room
  mount_uploader :image_link, ImageUploader
  scope :by_latest, ->{order created_at: :desc}
end
