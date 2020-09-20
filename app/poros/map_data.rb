class MapData
  attr_reader :latitude, :longitude, :city, :state, :country
  def initialize(data)
    @latitude = data[:results][0][:locations][0][:latLng][:lat]
    @longitude = data[:results][0][:locations][0][:latLng][:lng]
    @city = data[:results][0][:locations][0][:adminArea5]
    @state = data[:results][0][:locations][0][:adminArea3]
    @country = data[:results][0][:locations][0][:adminArea1]
  end
end
