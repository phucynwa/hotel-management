class Request < ApplicationRecord
  enum status: {created: 0, replied: 1, closed: 2}
  enum priority: {Normal: 1, Medium: 2, High: 3}

  belongs_to :user
  belongs_to :booking

  scope :by_latest, ->{order created_at: :desc}

  validates :content, :priority, :booking_id, presence: true
end
