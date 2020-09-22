require 'rails_helper'

RSpec.describe RouteService do
  it 'should get accurate responses' do
    lat = '39.738453'
    lon = '-104.984853'

    lat_to = '38.265425'
    lon_to = '-104.610415'

    data = File.read('spec/data/route_distance.json')
    stub = class_double('RouteService').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:get_parsed_route).and_return(JSON.parse(data, symbolize_names: true))
    results = RouteService.get_parsed_route(lat, lon, lat_to, lon_to)

    expect(results).to be_a Hash
    expect(results.keys).to include(:route)
    expect(results.keys).to include(:info)

    expect(results[:route].keys).to include(:distance)
  end
end
