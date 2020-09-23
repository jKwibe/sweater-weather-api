class TripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def forecast
    ForecastData.new(weather_service, map_data)
  end

  def map_data
    MapData.new(MapService.map_data(@destination))
  end

  def route_service
    RouteService.parsed_route(@destination, @origin)
  end

  def weather_service
    WeatherService.weather_data(map_data.latitude, map_data.longitude)
  end
end
