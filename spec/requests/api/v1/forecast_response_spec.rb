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

    expect(data[:data][:attributes].keys).to include(:state)
    expect(data[:data][:attributes].keys).to include(:city)
    expect(data[:data][:attributes].keys).to include(:country)
    expect(data[:data][:attributes].keys).to include(:current)
    expect(data[:data][:attributes].keys).to include(:hourly)
    expect(data[:data][:attributes].keys).to include(:daily)

    expect(data[:data][:attributes][:current].keys).to include(:sunrise)
    expect(data[:data][:attributes][:current].keys).to include(:sunset)
    expect(data[:data][:attributes][:current].keys).to include(:temp)
    expect(data[:data][:attributes][:current].keys).to include(:feels_like)
    expect(data[:data][:attributes][:current].keys).to include(:humidity)
    expect(data[:data][:attributes][:current].keys).to include(:icon)
    expect(data[:data][:attributes][:current].keys).to include(:uvi)
    expect(data[:data][:attributes][:current].keys).to include(:visibility)
    expect(data[:data][:attributes][:current].keys).to include(:weather_description)

    expect(data[:data][:attributes][:hourly][0].keys).to include(:time)
    expect(data[:data][:attributes][:hourly][0].keys).to include(:temp)
    expect(data[:data][:attributes][:hourly][0].keys).to include(:icon)

    expect(data[:data][:attributes][:daily][0].keys).to eq(%i[time temp_high temp_low precipitation description])
    expect(data[:data][:attributes][:daily][0].keys).to include(:time)
    expect(data[:data][:attributes][:daily][0].keys).to include(:temp_high)
    expect(data[:data][:attributes][:daily][0].keys).to include(:temp_low)
    expect(data[:data][:attributes][:daily][0].keys).to include(:precipitation)
    expect(data[:data][:attributes][:daily][0].keys).to include(:description)
  end

  it 'should get an error if location is not passed' do

    get "#{api_v1_forecast_path}?location="

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(422)
    expect(data[:data][:attributes].keys).to include(:message)
  end
end
