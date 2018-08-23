class RequestsController < ApplicationController
  before_action :logged_in_user, :verify_customer
  before_action :load_request, only: %i(edit update)

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t ".success"
      redirect_to user_path(current_user)
    else
      flash[:danger] = t ".warning"
      redirect_to new_request_path
    end
  end

  def edit; end

  def update
    if @request.update_attributes request_params
      flash[:success] = t ".request_update"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def request_params
    params.require(:request).permit :content, :priority, :booking_id
  end
end
