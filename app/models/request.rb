class Request < ApplicationRecord
  belongs_to :user
  belongs_to :booking
  enum status: {created: 0, accepted: 1, in_process: 2, solved: 3}
  enum priority: {Normal: 1, Medium: 2, High: 3}
  validates :content, :priority, :booking_id, presence: true
end
