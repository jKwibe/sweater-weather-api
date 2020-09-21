require 'rails_helper'

RSpec.describe 'GET climbing_routes' do
  it 'should get all climbing routes' do
    # stubs for the response
    lat = '39.738453'
    lon = '-104.984853'

    # Weather API STUB
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API']}&lat=#{lat}&lon=#{lon}&units=imperial")
      .to_return(status: 200, body: File.read('spec/data/weather-data.json'))

    # MOUNTAIN PROJECT API STUB
    stub = stub_request(:get, "https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=#{lat}&lon=#{lon}&key=#{ENV['MOUNTAIN_KEY']}")
      .to_return(status: 200, body: File.read('spec/data/hiking_routes_data.json'))
    data = JSON.parse(stub.response.body, symbolize_names: true)

    # MAPQUEST API STUB
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API']}&location=denver,co")
      .to_return(status: 200, body: File.read('spec/data/map_data.json'))

    # map through the to create get the distance
    data[:routes].each do |route|
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/route?key=#{ENV['MAP_API']}&from={latLng:{lat:#{lat},lng:#{lon}}}&to={latLng:{lat:#{route[:latitude]},lng:#{route[:longitude]}}}")
        .to_return(status: 200, body: File.read('spec/data/route_distance.json'))
    end

    get '/api/v1/climbing_routes?location=denver,co'

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(data[:data].keys).to eq(%i[id type attributes])
    expect(data[:data][:attributes].keys).to eq(%i[location forecast routes])
    expect(data[:data][:attributes][:forecast].keys).to eq(%i[summary temperature])
    expect(data[:data][:attributes][:routes]).to be_a_kind_of Array
    expect(data[:data][:attributes][:routes][0].keys).to eq(%i[name type rating location distance_to_route])
    expect(data[:data][:attributes][:routes][0][:location]).to be_a_kind_of Array
    expect(data[:data][:attributes][:location]).to be_a_kind_of String
  end
end
