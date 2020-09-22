require 'rails_helper'

RSpec.describe ClimbingService do
  it 'should get correct fields' do
    lat = '39.738453'
    lon = '-104.984853'

    data = File.read('spec/data/hiking_routes_data.json')
    stub = class_double('ClimbingService').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:get_parsed_data).and_return(JSON.parse(data, symbolize_names: true))
    results = ClimbingService.get_parsed_data(lat, lon)

    expect(results).to be_a Hash
    expect(results.keys).to include(:routes)
    expect(results[:routes]).to be_a Array
    expect(results[:routes][0]).to include(:location)
    expect(results[:routes][0]).to include(:rating)
    expect(results[:routes][0]).to include(:name)
    expect(results[:routes][0]).to include(:type)

    expect(results[:routes][5]).to include(:location)
    expect(results[:routes][5]).to include(:rating)
    expect(results[:routes][5]).to include(:name)
    expect(results[:routes][5]).to include(:type)


  end
end
