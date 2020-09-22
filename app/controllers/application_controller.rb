class ApplicationController < ActionController::API

  def current_user
    user_id = JsonWebToken.decode(params[:access_token])
    @current_user ||= User.find_by(id: user_id) if user_id
  end

  def authorize
    render json: ErrorSerializer.new(ErrorHandler.new('Not Authorized')), status: :unauthorized unless current_user
  end
end
