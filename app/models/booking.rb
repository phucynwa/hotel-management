class Booking < ApplicationRecord
  enum status: {created: 0, accepted: 1, checked_in: 2, checked_out: 3}
  before_validation :check_rooms_free, :check_time

  belongs_to :user
  has_one :bill
  has_many :requests
  has_many :booking_details
  has_many :rooms, through: :booking_details
  scope :by_latest, ->{order created_at: :desc}
  scope :by_room, ->(room){where rooms: room}
  scope :by_status, ->(status){where status: status}
  validates :start_time, :end_time, presence: true

  def check_rooms_free
    self.rooms.each do |room|
      if Booking.by_room(room).by_status(:accepted).select(:start_time, :end_time)
        .where("(start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?) OR ? BETWEEN start_time AND end_time",
          self.start_time, self.end_time, self.start_time, self.end_time, self.start_time).present?
        errors[:base] << I18n.t("bookings.create.warning")
        throw :abort
      end
    end
  end

  def check_time
    return if (start_time >= Time.now) && (end_time - start_time).minutes > Settings.min_times
    errors[:base] << I18n.t("bookings.create.warning")
    throw :abort
  end
end
