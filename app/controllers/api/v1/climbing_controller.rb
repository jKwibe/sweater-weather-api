class Api::V1::ClimbingController < ApplicationController
  def index
    # map_service = MapService.map_data(params[:location])
    # map_data = MapData.new(map_service)
    # lat = map_data.latitude
    # lon = map_data.longitude
    # weather_service = WeatherService.weather_data(lat, lon)
    # forecast = {
    #   summary: weather_service[:current][:weather][0][:description],
    #   temperature: weather_service[:current][:temp]
    # }
    # climbing_service = ClimbingService.get_parsed_data(lat, lon)
    # routes = climbing_service[:routes].map do |route|
    #   {
    #       name: route[:name],
    #       type: route[:type],
    #       rating: route[:rating],
    #       location: route[:location],
    #       distance_to_route: MapService.get_route(lat, lon, route[:latitude], route[:longitude])[:distance]
    #   }
    # end

    render json: ClimbingRouteSerializer.new(ClimbingFacade.new(params[:location]))
  end
end
