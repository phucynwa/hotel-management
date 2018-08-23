class Bill < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  scope :by_month_year, ->(month, year){where("YEAR(updated_at) = ? AND MONTH(updated_at) = ?", year ||= Time.now.year,
    month ||= Time.now.month)}
  validates :booking, uniqueness: {case_sensitive: false}
end
