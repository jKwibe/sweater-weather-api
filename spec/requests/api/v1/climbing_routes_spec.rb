require 'rails_helper'

RSpec.describe 'GET climbing_routes' do
  it 'should get all climbing routes' do
    # stubs for the response
    lat = '39.738453'
    lon = '-104.984853'
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API']}&lat=#{lat}&lon=#{lon}&units=imperial")
      .to_return(status: 200, body: File.read('spec/data/weather-data.json'))
    stub_request(:get, "https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=#{lat}&lon=#{lon}&key=#{ENV['MOUNTAIN_KEY']}")
      .to_return(status: 200, body: File.read('spec/data/hiking_routes_data.json'))

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API']}&location=denver,co")
      .to_return(status: 200, body: File.read('spec/data/map_data.json'))

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/route?key=#{ENV['MAP_API']}&from=Denver%2C+CO&to=Boulder%2C+CO&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
      .to_return(status: 200, body: File.read('spec/data/route_distance.json'))

    get '/api/v1/climbing_routes?location=denver,co'

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(data[:data].keys).to eq(%i[id type attributes])
    expect(data[:data][:attributes].keys).to eq(%i[location forecast routes distance_to_route])
    expect(data[:data][:attributes][:forecast].keys).to eq(%i[summary temperature])
    expect(data[:data][:attributes][:routes]).to be_a_kind_of Array
    expect(data[:data][:attributes][:routes][0].keys).to eq(%i[name type rating location])
    expect(data[:data][:attributes][:routes][0][:location]).to be_a_kind_of Array
    expect(data[:data][:attributes][:location]).to be_a_kind_of String
  end
end
