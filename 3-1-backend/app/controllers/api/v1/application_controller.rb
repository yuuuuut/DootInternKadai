class Api::V1::ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Helpers

  helper_method :current_user

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from Forbidden, with: :error403
  rescue_from ActiveRecord::RecordNotFound, with: :error404

  def authenticate_user!
    authenticate_api_v1_user!
  end

  def current_user
    current_api_v1_user
  end

  def error403
    render 'errors/403', status: :forbidden
  end

  def error404
    render 'errors/404', status: :not_found
  end
end
