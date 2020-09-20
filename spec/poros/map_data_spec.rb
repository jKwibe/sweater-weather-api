require 'rails_helper'

RSpec.describe MapData do
  before(:each) do
    @data = JSON.parse(File.read('spec/data/map_data.json'), symbolize_names: true)
    @map_data = MapData.new(@data)
  end
  it 'should exist' do
    expect(@map_data).to be_instance_of(MapData)
  end
  it '#latitude and #longitude' do
    expect(@map_data.latitude).to eq(@data[:results][0][:locations][0][:latLng][:lat])
    expect(@map_data.longitude).to eq(@data[:results][0][:locations][0][:latLng][:lng])
  end
  it '#city and #state and #country ' do
    expect(@map_data.city).to eq(@data[:results][0][:locations][0][:adminArea5])
    expect(@map_data.state).to eq(@data[:results][0][:locations][0][:adminArea3])
    expect(@map_data.country).to eq(@data[:results][0][:locations][0][:adminArea1])
  end
end
