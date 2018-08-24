class Bill < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  scope :by_month_year, ->(month_year){
    where("DATE_FORMAT(updated_at,'%m-%Y') = ?", month_year ||= Date.today.strftime("%m-%Y"))
  }
  validates :booking, uniqueness: {case_sensitive: false}
end
