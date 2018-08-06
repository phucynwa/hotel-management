class Admin::RoomsController < ApplicationController
  before_action :load_room, only: %i(edit update destroy)
  before_action :logged_in_user, :verify_staff

  def index; end

  def edit; end

  def update
    if @room.update_attributes room_params
      flash[:success] = t ".success"
      redirect_to edit_admin_room_path
    else
      render :edit
    end
  end

  def destroy
    if @room.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".not_found"
    end
    redirect_to admin_rooms_path
  end

  private

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room
    flash[:danger] = t ".not_found", id: params[:id]
    redirect_to admin_rooms_path
  end

  def room_params
    params.require(:room).permit :category_id, :label, :floor, :status,
      images_attributes: [:id, :room_id, :image_link]
  end
end
