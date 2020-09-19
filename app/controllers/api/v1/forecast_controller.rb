class Api::V1::ForecastController < ApplicationController
  def index
    latitude = '39.738453'
    longitude = '-104.984853'
    weather_conn = Faraday.new('https://api.openweathermap.org/data/2.5/')
    data = weather_conn.get('onecall') do |p|
      p.params[:appid] = ENV['WEATHER_API']
      p.params[:lat] = latitude
      p.params[:lon] = longitude
      p.params[:units] = 'imperial'
    end

    res = JSON.parse(data.body, symbolize_names: true)
    forecast = ForecastData.new(res)

    render json: ForecastSerializer.new(forecast)
  end
end
