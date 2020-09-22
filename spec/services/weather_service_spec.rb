require 'rails_helper'

RSpec.describe WeatherService do
  it 'should get correct fields' do
    lat = '39.738453'
    lon = '-104.984853'

    data = File.read('spec/data/weather-data.json')
    stub = class_double('WeatherService').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:weather_data).and_return(JSON.parse(data, symbolize_names: true))
    results = WeatherService.weather_data(lat, lon)

    expect(results).to be_a Hash
    expect(results.keys).to include(:current)
    expect(results.keys).to include(:hourly)
    expect(results.keys).to include(:daily)

    expect(results[:current].keys).to include(:dt)
    expect(results[:current].keys).to include(:sunrise)
    expect(results[:current].keys).to include(:sunset)
    expect(results[:current].keys).to include(:feels_like)
    expect(results[:current].keys).to include(:uvi)
    expect(results[:current].keys).to include(:visibility)
    expect(results[:current].keys).to include(:weather)
    expect(results[:current][:weather]).to be_a Array
    expect(results[:current][:weather][0]).to be_a Hash
    expect(results[:current][:weather][0]).to include(:icon)
    expect(results[:current][:weather][0]).to include(:main)
    expect(results[:current][:weather][0]).to include(:description)

    expect(results[:hourly]).to be_a Array
    expect(results[:hourly][0]).to include(:dt)
    expect(results[:hourly][0]).to include(:temp)
    expect(results[:hourly][0]).to include(:weather)

    expect(results[:daily]).to be_a Array
    expect(results[:daily][0]).to include(:dt)
    expect(results[:daily][0]).to include(:temp)
    expect(results[:daily][0]).to include(:rain)
    expect(results[:daily][0]).to include(:weather)
  end
end
