class RoomsController < ApplicationController
  before_action :load_room, only: :show

  def index
    @rooms = Room.by_category_id(params[:category_id]).by_floor(params[:floor])
      .page(params[:page]).per Settings.show_rooms
    respond_to do |format|
      format.html {render :index}
      format.js {}
    end
  end

  def show; end

  private

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room
    flash[:warning] = t ".room_not_exist"
    redirect_to root_path
  end
end
