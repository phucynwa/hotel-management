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

  def first_image_link room
    if room.images.present?
      room.images.first.image_link
    else
      Settings.default_image
    end
  end
end
