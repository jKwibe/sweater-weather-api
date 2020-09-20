class WeatherFacade
  attr_reader :id
  def initialize(location)
    @location = location
  end

  def map_data
    MapService.map_data(@location)
  end

  def map_info
    MapData.new(map_data)
  end

  def city
    map_info.city
  end

  def state
    map_info.state
  end

  def country
    map_info.country
  end

  def weather_data
    WeatherService.weather_data(map_info.latitude, map_info.longitude)
  end

  def forecast
    ForecastData.new(weather_data)
  end

  def current
    forecast.current
  end

  def hourly
    forecast.hourly
  end

  def daily
    forecast.daily
  end
end
