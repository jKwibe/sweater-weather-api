require 'rails_helper'

RSpec.describe MapService do
  it 'should give a response' do
    location = 'denver,co'

    data = File.read('spec/data/map_data.json')
    stub = class_double('MapService').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:map_data).and_return(JSON.parse(data, symbolize_names: true))

    map_data = MapService.map_data(location)

    expect(map_data).to be_a_kind_of Hash
    expect(map_data.keys).to include(:info)
    expect(map_data.keys).to include(:options)
    expect(map_data.keys).to include(:results)

    expect(map_data[:results][0].keys).to include(:locations)
    expect(map_data[:results][0].keys).to include(:providedLocation)
    expect(map_data[:results][0][:locations]).to be_a Array
    expect(map_data[:results][0][:locations][0][:latLng]).to include(:lat)
    expect(map_data[:results][0][:locations][0][:latLng]).to include(:lng)

    expect(map_data[:results][0][:locations][0]).to include(:latLng)
    expect(map_data[:results][0][:locations][0]).to include(:adminArea1)
    expect(map_data[:results][0][:locations][0]).to include(:adminArea3)
    expect(map_data[:results][0][:locations][0]).to include(:adminArea5)
  end
end
