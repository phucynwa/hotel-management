class Admin::RequestsController < ApplicationController
  before_action :logged_in_user, :verify_staff
  before_action :load_request, only: %i(edit update show)

  def index
    @request = Request.by_latest.includes(:user, :booking).page(params[:page]).per Settings.show
  end

  def show; end

  def update
    if @request.update request_params
      flash[:success] = t ".success"
      if request_params[:status] == "replied"
        send_notification t ".send_notification", content: @request.content
      elsif request_params[:status] == "closed"
        send_notification t ".send_notification2", content: @request.content
      end
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_booking_path(@request.booking)
  end

  private

  def request_params
    params.require(:request).permit :status
  end

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
    flash[:danger] = t ".not_found"
    redirect_to admin_bookings_path
  end

  def send_notification content
    Notification.create customer_id: @request.user.id, staff_id: current_user.id, content: content
  end
end
