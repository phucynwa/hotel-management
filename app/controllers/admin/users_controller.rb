class Admin::UsersController < ApplicationController
  before_action :verify_staff
  before_action :load_user, :verify_admin, :check_role, only: :update

  def index
    @users = User.page(params[:page]).per Settings.users.per_page
  end

  def update
    if @user.admin?
      flash[:danger] = t ".save_admin"
    else
      @user.update_columns role: params[:role]
      flash[:info] = t ".#{@user.role}", name: @user.name
    end
    redirect_to admin_users_path
  end

  private

  def check_role
    return if params[:role].present? && params[:role].to_sym != :admin
    flash[:danger] = t "users.invalid_action"
    redirect_to admin_users_path
  end
end
