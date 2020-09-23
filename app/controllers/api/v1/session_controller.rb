class Api::V1::SessionController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      user_token = { params: { access_token: token } }
      render json: UserSerializer.new(user, user_token), status: :ok
    else
      render json: ErrorSerializer.new(ErrorHandler.new('Provide Correct Credentials')), status: :bad_request
    end
  end
end
