class Api::V1::TripController < ApplicationController
  before_action :authorize
  def create
    if (params[:origin].nil? || params[:origin].empty?) || (params[:destination].nil? || params[:destination].empty?)
      render json: ErrorSerializer.new(ErrorHandler.new('Must have both origin and destination fields')), status: :bad_request
    else
      forecast = TripFacade.new(params[:origin], params[:destination]).forecast
      route = TripFacade.new(params[:origin], params[:destination]).route_service

      render json: TripSerializer.new(TripInfo.new(forecast, route, params[:origin], params[:destination])), status: :ok
    end
  end
end
