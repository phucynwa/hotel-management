class BookingsController < ApplicationController
  before_action :logged_in_user

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new booking_params
    @booking.transaction do
      @booking.user = current_user
      @booking.rooms << Room.find(params[:rooms])
      @booking.save
      flash[:success] = t ".create_success"
      redirect_to root_path
    end
    rescue
      flash.now[:warning] = t ".create_fail"
      render :new
  end

  private

  def booking_params
    params.require(:booking).permit :start_time, :end_time
  end
end
