class TripInfo
  attr_reader :id, :destination, :origin
  def initialize(trip_info, route, destination, origin)
    @forecast = trip_info
    @route = route
    @origin = origin
    @destination = destination
  end

  def destination_temperature
    @forecast.current[:temp]
  end

  def destination_weather_desc
    @forecast.current[:weather_description]
  end

  def time_taken
    @route[:route][:realTime]
  end
end
