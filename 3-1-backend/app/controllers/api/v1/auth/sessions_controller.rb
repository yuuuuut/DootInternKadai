class Api::V1::Auth::SessionsController < Api::V1::ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user
  end
end
