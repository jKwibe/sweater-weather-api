class ForecastFacade
  def initialize(location)
    @location = location
  end

  def weather_info
    WeatherService.weather_data(coordinates.latitude, coordinates.longitude)
  end

  def coordinates
    MapData.new(location_info)
  end

  private

  def location_info
    MapService.map_data(@location)
  end
end
