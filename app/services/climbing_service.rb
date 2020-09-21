class ClimbingService
  def self.get_parsed_data(lat, lon)
    JSON.parse(get_routes(lat, lon).body, symbolize_names: true)
  end

  def self.get_routes(lat, lon)
    conn.get('get-routes-for-lat-lon') do |p|
      p.params[:lat] = lat
      p.params[:lon] = lon
    end
  end

  def self.conn
    Faraday.new('https://www.mountainproject.com/data/') do |p|
      p.params[:key] = ENV['MOUNTAIN_KEY']
    end
  end
end
