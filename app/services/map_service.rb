class MapService
  def self.map_data(location)
    JSON.parse(get_map_data(location).body, symbolize_names: true)
  end

  def self.get_parsed_route(lat, lon, lat_to, lon_to)
    JSON.parse(get_route(lat, lon, lat_to, lon_to).body, symbolize_names: true)
  end

  def self.get_route(lat, lon, lat_to, lon_to)
    conn.get('route') do |p|
      p.params[:from] = "{latLng:{lat:#{lat},lng:#{lon}}}"
      p.params[:to] = "{latLng:{lat:#{lat_to},lng:#{lon_to}}}"
    end
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
