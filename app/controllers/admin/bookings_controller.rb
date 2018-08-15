class Admin::BookingsController < ApplicationController
  before_action :logged_in_user, :verify_staff
  before_action :load_booking, only: %i(edit update show)

  def index
    @bookings = Booking.by_latest.includes(:user, :booking_details)
                       .page(params[:page]).per Settings.show
    @statuses = Booking.statuses
  end

  def show; end

  def update
    if @booking.update booking_params
      flash[:success] = t ".success"
      redirect_to admin_bookings_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit :status
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking
    flash[:danger] = t ".not_found"
    redirect_to admin_bookings_path
  end
end
