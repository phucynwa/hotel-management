class Notification < ApplicationRecord
  validates :content, :customer_id, presence: true
end
