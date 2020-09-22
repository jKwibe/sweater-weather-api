require 'rails_helper'

RSpec.describe 'POST /api/v1/road_trip' do
  before(:each) do
    @user = User.create!(email: 'test@test.com', password: 'password')

    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['WEATHER_API']}&lat=39.738453&lon=-104.984853&units=imperial")
      .to_return(status: 200, body: File.read('spec/data/weather-data.json'))

    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAP_API']}&location=Pueblo,CO")
      .to_return(status: 200, body: File.read('spec/data/map_data.json'))

    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=Denver,CO&key=#{ENV['MAP_API']}&to=Pueblo,CO")
      .to_return(status: 200, body: File.read('spec/data/route_direction_data.json'))
  end
  it 'should respond with a body' do
    stub = class_double('JsonWebToken').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:decode).and_return(@user.id.to_i)
    header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    body = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO',
      access_token: 'token'
    }
    post '/api/v1/road_trip', params: body.to_json, headers: header

    res = JSON.parse(response.body, symbolize_names: true)

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)

    expect(res[:data][:attributes].keys).to include(:origin)
    expect(res[:data][:attributes].keys).to include(:destination)
    expect(res[:data][:attributes].keys).to include(:destination_temperature)
    expect(res[:data][:attributes].keys).to include(:destination_weather_desc)
    expect(res[:data][:attributes].keys).to include(:time_taken)
  end

  it 'should return error for an authorized user' do
    stub = class_double('JsonWebToken').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:decode).and_return(nil)
    header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    body = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO',
      access_token: 'token'
    }

    post '/api/v1/road_trip', params: body.to_json, headers: header

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should respond with a body' do
    stub = class_double('JsonWebToken').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:decode).and_return(@user.id.to_i)
    header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    body = {
      origin: '',
      destination: 'Pueblo,CO',
      access_token: 'token'
    }
    post '/api/v1/road_trip', params: body.to_json, headers: header

    res = JSON.parse(response.body, symbolize_names: true)

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unprocessable_entity)

    expect(res[:data].keys).to include(:id)
    expect(res[:data].keys).to include(:type)
    expect(res[:data].keys).to include(:attributes)

    expect(res[:data][:attributes][:message]).to be_a(String)
  end

end
