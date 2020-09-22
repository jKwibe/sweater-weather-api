class MapService
  def self.map_data(location)
    JSON.parse(get_map_data(location).body, symbolize_names: true)
  end

  def self.get_map_data(location)
    conn.get('address') do |p|
      p.params[:location] = location
    end

  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/geocoding/v1/') do |p|
      p.params[:key] = ENV['MAP_API']
    end
  end
end
