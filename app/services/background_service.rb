class BackgroundService
  def self.image_data(location)
    JSON.parse(get_background(location).body, symbolize_names: true)
  end

  def self.format_location(location)
    location.gsub(',', '+')
  end

  def self.get_background(location)
    conn.get('search/photos') do |p|
      p.params[:query] = format_location(location)
      p.params[:orientation] = 'landscape'
      p.params[:per_page] = 1
    end
  end

  def self.conn
    Faraday.new('https://api.unsplash.com/') do |p|
      p.params[:client_id] = ENV['UNSPLASH_API_ID']
      p.headers['Accept-Version'] = 'v1'
    end
  end
end
