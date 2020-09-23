class ForecastData
  attr_reader :id, :city, :state, :country
  def initialize(response, location)
    @current = response[:current]
    @hourly = response[:hourly]
    @daily = response[:daily]
    @city = location.city
    @state = location.state
    @country = location.country
  end

  def current
    {
      time: FormatDate.full_date_time(@current[:dt]),
      sunrise: FormatDate.full_time(@current[:sunrise]),
      sunset: FormatDate.full_time(@current[:sunset]),
      temp: @current[:temp],
      feels_like: @current[:feels_like],
      humidity: @current[:humidity],
      icon: "http://openweathermap.org/img/wn/#{@current[:weather][0][:icon]}.png",
      uvi: @current[:uvi],
      visibility: @current[:visibility],
      weather_description: @current[:weather][0][:description]
    }
  end

  def hourly
    @hourly.map do |weather|
      {
        time: FormatDate.short_time(weather[:dt]),
        temp: weather[:temp],
        icon: "http://openweathermap.org/img/wn/#{weather[:weather][0][:icon]}.png"
      }
    end
  end

  def daily
    @daily.map do |weather|
      {
        time: FormatDate.day(weather[:dt]),
        temp_high: weather[:temp][:max],
        temp_low: weather[:temp][:min],
        precipitation: weather[:rain],
        description: weather[:weather][0][:main]
      }
    end
  end
end


