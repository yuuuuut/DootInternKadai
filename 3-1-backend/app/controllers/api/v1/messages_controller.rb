class Api::V1::MessagesController < Api::V1::ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.create(message_params)
  end

  def update
    Message.where(room_id: params[:room_id], check: false).where.not(user_id: current_user.id).update(check: true)
  end

  private

  def message_params
    params.require(:message).permit(:body).merge(user_id: current_user.id, room_id: params[:room_id])
  end
end
