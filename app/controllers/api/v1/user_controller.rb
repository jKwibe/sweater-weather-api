class Api::V1::UserController < ApplicationController
  def create
    user = User.create!(user_params)
    token = JsonWebToken.encode(user_id: user.id)
    token_params = { params: { access_token: token } }
    render json: UserSerializer.new(user, token_params), status: :created
  rescue StandardError => e
    render json: ErrorSerializer.new(ErrorHandler.new(e)), status: :bad_request
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
