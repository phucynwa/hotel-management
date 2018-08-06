class Admin::ImagesController < ApplicationController
  before_action :load_image, only: :destroy
  before_action :logged_in_user, :verify_staff

  def index
    @images = Image.by_latest.page(params[:page]).per Settings.show
  end

  def destroy
    if @image.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".not_found"
    end
    redirect_to admin_images_path
  end

  private

  def load_image
    @image = Image.find_by id: params[:id]
    return if @image
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_images_path
  end
end
