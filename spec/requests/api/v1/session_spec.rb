require 'rails_helper'

RSpec.describe 'POST/ Login' do
  before(:each) do
    User.create!(email: 'test@test.com', password: '123456')
    @header = {
      'ACCEPT' => 'application/json',
      'CONTENT-TYPE' => 'application/json'
    }
  end
  it 'should sign up a user' do
    user_data = {
      email: 'test@test.com',
      password: '123456'
    }
    post  api_v1_session_path, params: user_data.to_json, headers: @header

    res = JSON.parse(response.body, symbolize_names: true)

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)
    expect(res[:data].keys).to eq(%i[id type attributes])
    expect(res[:data].keys).to include(:id)
    expect(res[:data].keys).to include(:type)
    expect(res[:data].keys).to include(:attributes)

    expect(res[:data][:attributes].keys).to include(:email)
    expect(res[:data][:attributes].keys).to include(:access_token)

    expect(res[:data][:attributes][:email]).to be_a_kind_of String
    expect(res[:data][:attributes][:email]).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/)
    expect(res[:data][:attributes][:email]).to be_a_kind_of String
  end

  it 'should return an error response' do
    user_data = {
      email: 'test@test.com',
      password: 'wrong password'
    }
    post  api_v1_session_path, params: user_data.to_json, headers: @header

    res = JSON.parse(response.body, symbolize_names: true)

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:not_acceptable)
    expect(res[:data][:attributes].keys).to eq(%i[message])
    expect(res[:data][:attributes][:message]).to be_a_kind_of String
    expect(res[:data][:attributes][:message]).to eq('Provide Correct Credentials')
  end
end
