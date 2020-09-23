require 'rails_helper'

RSpec.describe 'GET /background' do
  it 'should get an image of a city' do
    # Web Stubs
    stub_request(:get, "https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_API_ID']}&orientation=landscape&per_page=1&query=denver%2Bco")
      .to_return(status: 200, body: File.read('spec/data/image_data.json'))

    location = 'denver,co'

    get "#{api_v1_background_path}?location=#{location}"

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(data[:data][:attributes].keys).to include(:image_url)
    expect(data[:data][:attributes].keys).to include(:credit_to)

    expect(data[:data][:attributes][:credit_to]).to be_a(String)
    expect(data[:data][:attributes][:image_url]).to be_a(String)
    expect(data[:data][:attributes][:image_url]).to match(%r{https?://[\S]+})
  end

  it 'should get an error if location is not passed' do

    get "#{api_v1_background_path}?location="

    data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(data[:data][:attributes].keys).to include(:message)
  end
end
