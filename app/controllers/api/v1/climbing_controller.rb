class Api::V1::ClimbingController < ApplicationController
  def index
    render json: ClimbingRouteSerializer.new(ClimbingFacade.new(params[:location])), status: :ok
  end
end
