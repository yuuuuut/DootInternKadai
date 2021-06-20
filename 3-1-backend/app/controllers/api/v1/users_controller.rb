class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @room_id, @is_room = current_user.user_with_room(@user)
  end
end
