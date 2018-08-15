class BookingsController < ApplicationController
  before_action :logged_in_user

  before_action :load_booking, only: %i(edit update)

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new booking_params
    if params[:rooms].present?
      @booking.transaction do
        @booking.user = current_user
        @booking.rooms << Room.find(params[:rooms])
        if @booking.save
          flash[:success] = t ".create_success"
          redirect_to root_path
        else
          flash.now[:warning] = t ".create_fail"
          render :new
        end
      end
    else
      flash.now[:warning] = t ".select_room_require"
      render :new
    end
  end

  def edit; end

  def update
    if params[:rooms].present?
      @booking.transaction do
        if @booking.update_attributes(booking_params)
          @booking.room_ids = params[:rooms]
          flash[:success] = t ".booking_updated"
          redirect_to current_user
        else
          render :edit
        end
      end
    else
      flash.now[:warning] = t "create.select_room_require"
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit :start_time, :end_time
  end

  def load_booking
    @booking = Booking.find_by id: params[:id], user_id: current_user.id
    return if @booking
    flash[:warning] = t "bookings.user_not_exist"
    redirect_to root_path
  end
end
