class Admin::NotificationsController < ApplicationController
  before_action :logged_in_user, :verify_staff
  before_action :load_notification, only: %i(edit update destroy)

  def index
    @notifications = Notification.by_latest.page(params[:page]).per Settings.show
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new notification_params
    if @notification.save
      flash[:success] = t ".send_success"
      redirect_to admin_notifications_path
    else
      flash.now[:warning] = t ".send_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @notification.update_attributes notification_params
      flash[:success] = t ".notification_update"
      redirect_to admin_notifications_path
    else
      render :edit
    end
  end

  def destroy
    if @notification.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".warning"
    end
    redirect_to admin_notifications_path
  end

  private

  def load_notification
    @notification = Notification.find_by id: params[:id]
    return if @notification
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_notifications_path
  end

  def notification_params
    params.require(:notification).permit :content, :staff_id, :customer_id
  end
end
