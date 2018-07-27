class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "users.user_not_exist"
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "users.login_request"
      redirect_to login_path
    end
  end

  def not_logged_in
    if logged_in?
      flash[:warning] = t "users.invalid_action"
      redirect_to root_path
    end
  end
end
