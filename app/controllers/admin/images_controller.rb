class Admin::ImagesController < ApplicationController
  before_action :load_image, only: :destroy
  before_action :logged_in_user, :verify_staff

  def index
    @images = Image.by_latest.page(params[:page]).per Settings.show
  end

  def destroy
    if @image.destroy
      flash[:success] = t "images.success"
      redirect_to images_path
    else
      flash[:danger] = t "images.not_found"
      redirect_to images_path
    end
  end

  private

  def load_image
    @image = Image.find_by id: params[:id]
    return if @image
    flash[:danger] = t "images.not_found", id: params[:id]
    redirect_to images_path
  end
end
