class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new show create)
  before_action :not_logged_in, only: %i(new create)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".sign_up_successful"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t ".user_not_exist"
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".login_request"
      redirect_to login_path
    end
  end

  def not_logged_in
    if logged_in?
      flash[:warning] = t ".invalid_action"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :phone, :password,
      :password_confirmation
  end
end
