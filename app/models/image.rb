class Image < ApplicationRecord
  belongs_to :room
  scope :by_latest, ->{order created_at: :desc}
end
