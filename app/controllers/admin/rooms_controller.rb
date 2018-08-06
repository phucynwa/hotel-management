class Admin::RoomsController < ApplicationController
  before_action :load_room, only: %i(edit update destroy)
  before_action :logged_in_user, :verify_staff
  before_action :room_params, only: :update

  def index; end

  def edit; end

  def update
    if @room.update_attributes room_params
      insert_room
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

  def insert_room
    ActiveRecord::Base.transaction do
      @room.save
      params[:images]["image_link"].each do |image|
        @image = Image.create room_id: @room.id, image_link: image
        @image.save
      end
    end
    return unless @room.persisted?
  end

  def room_params
    params.require(:room).permit :category_id, :label, :floor, :status,
      images_attributes: [:id, :room_id, :image_link]
  end
end
