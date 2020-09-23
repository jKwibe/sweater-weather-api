require 'rails_helper'

RSpec.describe ForecastData do
  before(:each) do
    @data = JSON.parse(File.read('spec/data/weather-data.json'), symbolize_names: true)
    map_info = JSON.parse(File.read('spec/data/map_data.json'), symbolize_names: true)
    @loc = MapData.new(map_info)
    @forecast = ForecastData.new(@data, @loc)
  end
  it 'should exist' do
    expect(@forecast).to be_instance_of(ForecastData)
  end

  it '#current' do
    expect(@forecast.current).to be_a_kind_of Hash
    expect(@forecast.current.keys).to include(:time)
    expect(@forecast.current.keys).to include(:sunrise)
    expect(@forecast.current.keys).to include(:sunset)
    expect(@forecast.current.keys).to include(:temp)
    expect(@forecast.current.keys).to include(:feels_like)
    expect(@forecast.current.keys).to include(:humidity)
    expect(@forecast.current.keys).to include(:icon)
    expect(@forecast.current.keys).to include(:uvi)
    expect(@forecast.current.keys).to include(:visibility)
    expect(@forecast.current.keys).to include(:weather_description)

    expect(@forecast.current[:time]).to eq(FormatDate.full_date_time(@data[:current][:dt]))
    expect(@forecast.current[:sunrise]).to eq(FormatDate.full_time(@data[:current][:sunrise]))
    expect(@forecast.current[:sunset]).to eq(FormatDate.full_time(@data[:current][:sunset]))
    expect(@forecast.current[:temp]).to eq(@data[:current][:temp])
    expect(@forecast.current[:feels_like]).to eq(@data[:current][:feels_like])
    expect(@forecast.current[:humidity]).to eq(@data[:current][:humidity])
    expect(@forecast.current[:icon]).to include(@data[:current][:weather][0][:icon])
    expect(@forecast.current[:uvi]).to eq(@data[:current][:uvi])
    expect(@forecast.current[:visibility]).to eq(@data[:current][:visibility])
    expect(@forecast.current[:weather_description]).to eq(@data[:current][:weather][0][:description])
  end

  it '#hourly' do
    expect(@forecast.hourly).to be_a_kind_of Array
    expect(@forecast.hourly[0].keys).to include(:time)
    expect(@forecast.hourly[0].keys).to include(:icon)
    expect(@forecast.hourly[0].keys).to include(:temp)

    expect(@forecast.hourly[0][:time]).to eq(FormatDate.short_time(@data[:hourly][0][:dt]))
    expect(@forecast.hourly[0][:temp]).to eq(@data[:hourly][0][:temp])
    expect(@forecast.hourly[0][:icon]).to include(@data[:hourly][0][:weather][0][:icon])
  end

  it '#daily' do
    expect(@forecast.daily).to be_a_kind_of Array
    expect(@forecast.daily[0].keys).to eq(%i[time temp_high temp_low precipitation description])
    expect(@forecast.daily[0].keys).to include(:time)
    expect(@forecast.daily[0].keys).to include(:temp_high)
    expect(@forecast.daily[0].keys).to include(:temp_low)
    expect(@forecast.daily[0].keys).to include(:precipitation)
    expect(@forecast.daily[0].keys).to include(:description)

    expect(@forecast.daily[0][:time]).to eq(FormatDate.day(@data[:daily][0][:dt]))
    expect(@forecast.daily[0][:temp_high]).to eq(@data[:daily][0][:temp][:max])
    expect(@forecast.daily[0][:temp_low]).to eq(@data[:daily][0][:temp][:min])
    expect(@forecast.daily[0][:precipitation]).to eq(@data[:daily][0][:rain])
    expect(@forecast.daily[0][:description]).to eq(@data[:daily][0][:weather][0][:main])
  end
end
