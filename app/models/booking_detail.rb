class BookingDetail < ApplicationRecord
  belongs_to :room
  belongs_to :booking
end
