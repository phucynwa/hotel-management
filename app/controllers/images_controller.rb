class ImagesController < ApplicationController
  before_action :logged_in_user

  def index
    @images = Image.by_latest.page(params[:page]).per Settings.show
  end
end
