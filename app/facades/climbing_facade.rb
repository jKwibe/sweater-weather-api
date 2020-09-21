class ClimbingFacade
  attr_reader :location, :id
  def initialize(location)
    @location = location
  end

  def map_data
    map_service = MapService.map_data(@location)
    MapData.new(map_service)
  end

  def forecast
    weather_service = WeatherService.weather_data(map_data.latitude, map_data.longitude)
    {
      summary: weather_service[:current][:weather][0][:description],
      temperature: weather_service[:current][:temp]
    }
  end

  def routes
    climbing_service = ClimbingService.get_parsed_data(map_data.latitude, map_data.longitude)
    climbing_service[:routes].map do |route|
      {
        name: route[:name],
        type: route[:type],
        rating: route[:rating],
        location: route[:location],
        distance_to_route: MapService.get_parsed_route(map_data.latitude, map_data.longitude, route[:latitude], route[:longitude])[:route][:distance]
      }
    end
  end
end
