class Api::V1::RoomsController < Api::V1::ApplicationController
  include Pagination

  before_action :authenticate_user!
  before_action :set_room, only: %i[show]
  before_action :room_in_current_user, only: %i[show]

  def index
    @rooms = current_user.rooms.preload(:users, :messages).page(params[:page]).per(3)
    @add_information_rooms = Room.room_add_necessary_information(@rooms, current_user)
    @pagination = resources_with_pagination(@rooms)
  end

  def show
    messages = @room.messages.preload(:user).order(created_at: :desc).page(params[:page]).per(6)
    @messages = messages.reverse
    @pagination = resources_with_pagination(messages)
  end

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
