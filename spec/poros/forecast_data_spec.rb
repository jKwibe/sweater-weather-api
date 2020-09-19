require 'rails_helper'

RSpec.describe ForecastData do
  before(:each) do
    @data = JSON.parse(File.read('spec/data/weather-data.json'), symbolize_names: true)
    @forecast = ForecastData.new(@data)
    @off_set = @data[:timezone_offset]
  end
  it 'should exist' do
    expect(@forecast).to be_instance_of(ForecastData)
  end

  it '#current' do
    expect(@forecast.current).to be_a_kind_of Hash
    expect(@forecast.current.keys).to eq(%i[time sunrise sunset temp feels_like humidity icon uvi visibility weather_description])
    expect(@forecast.current[:time]).to eq(FormatDate.full_date_time(@data[:current][:dt] + @off_set))
    expect(@forecast.current[:sunrise]).to eq(FormatDate.full_time(@data[:current][:sunrise] + @off_set))
    expect(@forecast.current[:sunset]).to eq(FormatDate.full_time(@data[:current][:sunset] + @off_set))
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
    expect(@forecast.hourly[0].keys).to eq(%i[time temp icon])
    expect(@forecast.hourly[0][:time]).to eq(FormatDate.short_time(@data[:hourly][0][:dt] + @off_set))
    expect(@forecast.hourly[0][:temp]).to eq(@data[:hourly][0][:temp])
    expect(@forecast.hourly[0][:icon]).to include(@data[:hourly][0][:weather][0][:icon])
  end

  it '#daily' do
    expect(@forecast.daily).to be_a_kind_of Array
    expect(@forecast.daily[0].keys).to eq(%i[time temp_high temp_low precipitation description])
    expect(@forecast.daily[0][:time]).to eq(FormatDate.day(@data[:daily][0][:dt] + @off_set))
    expect(@forecast.daily[0][:temp_high]).to eq(@data[:daily][0][:temp][:max])
    expect(@forecast.daily[0][:temp_low]).to eq(@data[:daily][0][:temp][:min])
    expect(@forecast.daily[0][:precipitation]).to eq(@data[:daily][0][:rain])
    expect(@forecast.daily[0][:description]).to eq(@data[:daily][0][:weather][0][:main])
  end
end
