class MapService
  def self.map_data(location)
    Rails.cache.fetch("map-#{location}", expires_in: 24.hours) do
      JSON.parse(get_map_data(location).body, symbolize_names: true)
    end
  end

  def self.get_map_data(location)
    conn.get('address') do |p|
      p.params[:key] = ENV['MAP_API']
      p.params[:location] = location
    end

  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1/')
  end
end
