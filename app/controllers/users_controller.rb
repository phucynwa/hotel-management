class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new create)
  before_action :not_logged_in, only: %i(new create)
  before_action :correct_user, only: %i(edit update)
  before_action :verify_staff, only: :index

  def index
    @users = User.page(params[:page]).per Settings.users.per_page
  end

  def show; end

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
      flash[:success] = t ".profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user.current_user? @user
  end

  def user_params
    params.require(:user).permit :name, :email, :phone, :password,
      :password_confirmation
  end
end
