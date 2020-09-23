class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].nil? || params[:location].empty?
      render json: ErrorSerializer.new(ErrorHandler.new('Location parameters cannot be blank')), status: :unprocessable_entity
    else
      weather = ForecastFacade.new(params[:location]).weather_info
      loc = ForecastFacade.new(params[:location]).coordinates

      render json: ForecastSerializer.new(ForecastData.new(weather, loc)), status: :ok
    end
  end
end
