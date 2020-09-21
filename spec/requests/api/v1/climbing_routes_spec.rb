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

    get '/api/v1/climbing_routes?location=denver,co'

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(data[:data].keys).to eq(%i[id type attributes])
  end
end
