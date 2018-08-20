module ApplicationHelper
  def full_title page_title
    base_title = t ".base_title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def class_type status
    case status.to_sym
    when :free
      "info"
    when :booked
      "warning"
    when :used
      "danger"
    when :maintenance
      "default"
    end
  end

  def type_status_booking status
    case status.to_sym
    when :created
      "info"
    when :accepted
      "warning"
    when :checked_in
      "danger"
    when :checked_out
      "default"
    end
  end

  def first_image_link room
    if room.images.present?
      room.images.first.image_link.url
    else
      Settings.default_image
    end
  end

  def all_category
    Category.all
  end

  def all_room
    Room.all.page(params[:page]).per Settings.show_rooms
  end

  def all_room_available
    Room.all.not_maintenance
  end

  def max_floor
    Room.maximum :floor
  end
end
