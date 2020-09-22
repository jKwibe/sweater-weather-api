class ClimbingFacade
  attr_reader :location, :id
  def initialize(location)
    @location = location
  end

  def forecast
    {
      summary: weather_service[:current][:weather][0][:description],
      temperature: weather_service[:current][:temp]
    }
  end

  def routes
    climbing_service[:routes].map do |route|
      {
        name: route[:name],
        type: route[:type],
        rating: route[:rating],
        location: route[:location],
        distance_to_route: get_distance(route[:latitude], route[:longitude])
      }
    end
  end

  private

  def get_distance(lat_to, lon_to)
    RouteService.get_parsed_route(map_data.latitude, map_data.longitude, lat_to, lon_to)[:route][:distance]
  end

  def map_data
    map_service = MapService.map_data(@location)
    MapData.new(map_service)
  end

  def weather_service
    WeatherService.weather_data(map_data.latitude, map_data.longitude)
  end


  def climbing_service
    ClimbingService.get_parsed_data(map_data.latitude, map_data.longitude)
  end

end
# TODO: Create PORO to clean up the Facade
# TODO: Optimization since the call is a little bit slow.
