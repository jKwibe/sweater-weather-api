require 'rails_helper'

RSpec.describe 'GET /forecast' do
  it 'get forecast data' do
    # stubs
    stub_request(:get, 'https://api.openweathermap.org/data/2.5/onecall?appid=bc0fcf68e17788936275cb538e320fdc&lat=39.738453&lon=-104.984853')
        .to_return(status: 200, body: File.read('spec/data/weather-data.json'))

    get api_v1_forecast_path

    data = JSON.parse(response.body, symbolize_names: true)
    # data = {
    #   city: '',
    #   country: '',
    #   current: {
    #     time: 'date and time',
    #     sunrise: '',
    #     sunset: '',
    #     temp: '',
    #     feels_like: '',
    #     humidity: '',
    #     icon: '',
    #     temp_high: '',
    #     temp_low: '',
    #     weather_description: ''
    #   },
    #   hourly: [
    #     {
    #       icon: '',
    #       time: '',
    #       temp: ''
    #     },
    #     {
    #       icon: '',
    #       time: '',
    #       temp: ''
    #     }
    #   ],
    #   daily: [
    #     {
    #       time: '',
    #       temp_high: '',
    #       temp_low: '',
    #       precipitation: ''
    #     },
    #     {
    #       time: '',
    #       temp_high: '',
    #       temp_low: '',
    #       precipitation: ''
    #     }
    #   ]
    # }

    # expect(response.status).to eq(200)
    expect(data[:city]).to be_a(String)
    expect(data[:country]).to be_a(String)
    expect(data[:current]).to be_a(Hash)
    expect(data[:hourly]).to be_a(Array)
    expect(data[:daily]).to be_a(Array)

    expect(data.keys).to eq(%i[city country current hourly daily])
    expect(data[:current].keys).to eq(%i[time sunrise sunset temp feels_like humidity icon temp_high temp_low weather_description])
    expect(data[:hourly][0].keys).to eq(%i[icon time temp])
    expect(data[:daily][0].keys).to eq(%i[time temp_high temp_low precipitation])
  end
end
