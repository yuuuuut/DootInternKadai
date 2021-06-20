class Api::V1::RoomsController < Api::V1::ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[show]
  before_action :room_in_current_user, only: %i[show]

  def index
    @rooms = Room.room_add_necessary_information(current_user)
  end

  def show; end

  def create
    @room = Room.room_with_entry_create(current_user.id, params[:user_id])
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_in_current_user
    raise Forbidden unless @room.users.include?(current_user)
  end
end
