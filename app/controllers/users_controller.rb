class UsersController < ApplicationController
  before_action :load_user, :logged_in_user, except: %i(new create)
  before_action :not_logged_in, only: %i(new create)
  before_action :correct_user, only: %i(edit update)
  before_action :verify_staff, only: :index
  before_action :hide_other_customers, only: :show
  before_action :load_notifitions, only: :show

  def show
    @ratings = @user.ratings
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t ".sign_up_successful"
      redirect_to root_path
    else
      flash.now[:warning] = t ".sign_up_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user.current_user? @user
    flash[:warning] = t "users.invalid_action"
    redirect_to root_path
  end

  def load_notifitions
    @notifications = User.get_notifications(current_user.id).page(params[:page])
      .per Settings.notifications.per_page
  end

  def hide_other_customers
    @user = User.find_by id: params[:id]
    return unless @user&.customer? && current_user&.customer? &&
      !current_user&.current_user?(@user)
    flash[:warning] = t ".not_permission"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :phone, :password,
      :password_confirmation
  end
end
