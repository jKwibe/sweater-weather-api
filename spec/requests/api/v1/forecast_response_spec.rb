require 'rails_helper'

RSpec.describe 'GET /forecast' do
  it 'get forecast data' do
    # stubs
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API']}&lat=39.738453&lon=-104.984853&units=imperial")
      .to_return(status: 200, body: File.read('spec/data/weather-data.json'))

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API']}&location=denver,co")
      .to_return(status: 200, body: File.read('spec/data/map_data.json'))

    get "#{api_v1_forecast_path}?location=denver,co"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(data[:data][:attributes][:city]).to be_a(String)
    expect(data[:data][:attributes][:state]).to be_a(String)
    expect(data[:data][:attributes][:country]).to be_a(String)
    expect(data[:data][:attributes][:current]).to be_a(Hash)
    expect(data[:data][:attributes][:hourly]).to be_a(Array)
    expect(data[:data][:attributes][:daily]).to be_a(Array)

    expect(data[:data][:attributes].keys).to eq(%i[current hourly daily city state country])
    expect(data[:data][:attributes][:current].keys).to eq(%i[time sunrise sunset temp feels_like humidity icon uvi visibility weather_description])
    expect(data[:data][:attributes][:hourly][0].keys).to eq(%i[time temp icon])
    expect(data[:data][:attributes][:daily][0].keys).to eq(%i[time temp_high temp_low precipitation description])
  end
end
