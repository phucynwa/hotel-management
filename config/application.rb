require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

module HotelManagement
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = "Bangkok"
    config.active_record.default_timezone = :local
    Faker::Config.locale = :vi
  end
end
