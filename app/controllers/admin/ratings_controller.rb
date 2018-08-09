class Admin::RatingsController < ApplicationController
  before_action :logged_in_user, :verify_staff

  def index
    @ratings = Rating.by_latest.page(params[:page]).per Settings.show
  end
end
