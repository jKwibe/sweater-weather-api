class ForecastData
  attr_reader :id
  def initialize(response)
    @current = response[:current]
    @hourly = response[:hourly]
    @daily = response[:daily]
    @off_set = response[:timezone_offset]
  end

  def current
    {
      time: FormatDate.full_date_time(@current[:dt] + @off_set),
      sunrise: FormatDate.full_time(@current[:sunrise] + @off_set),
      sunset: FormatDate.full_time(@current[:sunset] + @off_set),
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
        time: FormatDate.short_time(weather[:dt] + @off_set),
        temp: weather[:temp],
        icon: "http://openweathermap.org/img/wn/#{weather[:weather][0][:icon]}.png"
      }
    end
  end

  def daily
    @daily.map do |weather|
      {
        time: FormatDate.day(weather[:dt] + @off_set),
        temp_high: weather[:temp][:max],
        temp_low: weather[:temp][:min],
        precipitation: weather[:rain],
        description: weather[:weather][0][:main]
      }
    end
  end
end


