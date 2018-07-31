class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
    only: %i(edit update)
  before_action :not_logged_in

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".instruction"
      redirect_to root_path
    else
      flash.now[:danger] = t ".email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".password_not_empty")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attributes reset_digest: nil
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    unless @user&.authenticated?(:reset, params[:id])
      redirect_to root_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t ".password_expired"
      redirect_to new_password_reset_path
    end
  end
end
