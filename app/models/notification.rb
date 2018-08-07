class Notification < ApplicationRecord
  validates :content, :customer_id, presence: true
  scope :by_latest, ->{order created_at: :desc}
end
