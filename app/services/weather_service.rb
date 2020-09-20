class WeatherService
  def self.weather_data(lat, lng, units = 'imperial')
    JSON.parse(get_weather_data(lat, lng, units).body, symbolize_names: true)
  end

  def self.get_weather_data(lat, lng, units)
    conn.get('onecall') do |p|
      p.params[:appid] = ENV['WEATHER_API']
      p.params[:lat] = lat
      p.params[:lon] = lng
      p.params[:units] = units
    end
  end

  def self.conn
    Faraday.new('https://api.openweathermap.org/data/2.5/')
  end
end
