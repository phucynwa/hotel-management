class Admin::RequestsController < ApplicationController
  before_action :logged_in_user, :verify_staff

  def index
    @requests = Request.by_latest.page(params[:page]).per Settings.show
  end
end
