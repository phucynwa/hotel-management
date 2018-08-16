class Admin::RoomsController < ApplicationController
  before_action :load_room, except: %i(index new create)
  before_action :logged_in_user, :verify_staff

  def new
    @room = Room.new
    Settings.image_quantity.times do
      @image = @room.images.build
    end
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t ".create_room_successful"
      redirect_to admin_rooms_path
    else
      flash.now[:warning] = t ".create_room_fail"
      render :new
    end
  end

  def index
    @rooms = Room.all.order(:status).page(params[:page]).per Settings.show
    @statuses = Room.statuses
  end

  def edit; end

  def update
    if @room.update_attributes room_params
      flash[:success] = t ".success"
      redirect_to admin_rooms_path
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
