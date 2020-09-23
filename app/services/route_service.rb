class RouteService
  def self.parsed_route(to, from)
    Rails.cache.fetch("#{to}+#{from}", expires_in: 24.hours) do
      JSON.parse(get_route(to, from).body, symbolize_names: true)
    end
  end

  def self.get_route(to, from)
    conn.get('route') do |p|
      p.params[:to] = to
      p.params[:from] = from
    end
  end

  def self.conn
    Faraday.new('http://www.mapquestapi.com/directions/v2/') do |p|
      p.params[:key] = ENV['MAP_API']
    end
  end
end
