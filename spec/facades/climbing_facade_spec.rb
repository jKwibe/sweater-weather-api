require 'rails_helper'

RSpec.describe ClimbingFacade do
  before :each do
    @location = 'denver,co'
    lat = '39.738453'
    lon = '-104.984853'
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API']}&lat=39.738453&lon=-104.984853&units=imperial")
      .to_return(status: 200, body: File.read('spec/data/weather-data.json'))

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API']}&location=#{@location}")
      .to_return(status: 200, body: File.read('spec/data/map_data.json'))

    stub = stub_request(:get, "https://www.mountainproject.com/data/get-routes-for-lat-lon?lat=#{lat}&lon=#{lon}&key=#{ENV['MOUNTAIN_KEY']}")
           .to_return(status: 200, body: File.read('spec/data/hiking_routes_data.json'))

    data = JSON.parse(stub.response.body, symbolize_names: true)


    # map through the to create get the distance
    data[:routes].each do |route|
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from={latLng:{lat:#{lat},lng:#{lon}}}&key=#{ENV['MAP_API']}&to={latLng:{lat:#{route[:latitude]},lng:#{route[:longitude]}}}")
        .to_return(status: 200, body: File.read('spec/data/route_distance.json'))
    end


    @facade = ClimbingFacade.new(@location)
  end
  it '#forecast' do
    expect(@facade.forecast).to be_a Hash
    expect(@facade.forecast).to include :summary
    expect(@facade.forecast).to include :temperature
    expect(@facade.forecast[:summary]).to be_a String
    expect(@facade.forecast[:temperature]).not_to be_nil
  end

  it '#routes' do
    expect(@facade.routes).to be_a Array
    expect(@facade.routes[0]).to be_a Hash
    expect(@facade.routes[0]).to include :name
    expect(@facade.routes[0]).to include :type
    expect(@facade.routes[0]).to include :rating
    expect(@facade.routes[0]).to include :location
    expect(@facade.routes[0]).to include :distance_to_route

    expect(@facade.routes[0][:name]).not_to be_nil
    expect(@facade.routes[0][:type]).not_to be_nil
    expect(@facade.routes[0][:rating]).not_to be_nil
    expect(@facade.routes[0][:location]).not_to be_nil
    expect(@facade.routes[0][:distance_to_route]).not_to be_nil
  end
end
