class Admin::BillsController < ApplicationController
  include ApplicationHelper
  before_action :verify_staff
  before_action :load_bill, only: :show
  before_action :checked_in_booking, only: %i(new create)
  before_action :create_bill_code, only: :new

  def index
    @bills = Bill.by_month_year(params[:month_year])
      .page(params[:page]).per Settings.users.per_page
  end

  def new; end

  def create
    @bill.user = current_user
    if @bill.save
      @bill.booking.checked_out!
      redirect_to admin_bill_path(@bill)
    else
      flash.now[:warning] = t ".recheck"
      render :new
    end
  end

  def show
    @room_amount = @bill.booking.rooms.includes(:category).sum "categories.price"
    @service_amount = @bill.booking.amount - @room_amount
  end

  private

  def bill_params
    params.require(:bill).permit :code, :booking_id
  end

  def create_bill_code
    @bill.code = DateTime.now.to_date.strftime("%Y-%m-") + @bill.booking.id.to_s
  end

  def load_bill
    @bill = Bill.find_by id: params[:id]
    return if @bill
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_bills_path
  end

  def checked_in_booking
    @bill = Bill.new bill_params
    return if @bill.booking.checked_in?
    flash[:info] = t ".booking_not_check_in"
    redirect_to admin_bookings_path
  end
end
