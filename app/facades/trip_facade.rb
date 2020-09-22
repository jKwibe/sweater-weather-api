class TripFacade
  attr_reader :destination, :origin, :id
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def map_data
    MapData.new(MapService.map_data(@destination))
  end

  def forecast
    ForecastData.new(WeatherService.weather_data(map_data.latitude, map_data.longitude))
  end

  def destination_temperature
    forecast.current[:temp]
  end

  def destination_weather_desc
    forecast.current[:weather_description]
  end

  def time_taken
    route_service[:route][:realTime]
  end

  def route_service
    RouteService.parsed_route(@destination, @origin)
  end
end
