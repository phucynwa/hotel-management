class Request < ApplicationRecord
  belongs_to :user

  validates :content, :status, :priority, presence: true
end
