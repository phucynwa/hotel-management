class Rating < ApplicationRecord
  belongs_to :user
  scope :by_latest, ->{select("ratings.*, users.name").joins(:user).order created_at: :desc}
  validates :content, presence: true
end
