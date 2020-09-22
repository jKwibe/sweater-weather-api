require 'rails_helper'

RSpec.describe 'POST/ sign up' do
  it 'should sign up a user' do
    header = {
      'ACCEPT' => 'application/json',
      'CONTENT-TYPE' => 'application/json'
    }

    user_data = {
      email: 'test@test.com',
      password: '123456',
      password_confirmation: '123456'
    }
    post  api_v1_sign_up_path, params: user_data.to_json, headers: header

    res = JSON.parse(response.body, symbolize_names: true)

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:created)
    expect(res[:data][:attributes].keys).to include(:email)
    expect(res[:data][:attributes].keys).to include(:access_token)

    expect(res[:data][:attributes][:email]).to be_a_kind_of String
    expect(res[:data][:attributes][:email]).to match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/)
    expect(res[:data][:attributes][:email]).to be_a_kind_of String
  end

  it 'should return and error response if incorrect data' do
    header = {
      'ACCEPT' => 'application/json',
      'CONTENT-TYPE' => 'application/json'
    }

    user_data = {
      email: '',
      password: '123456',
      password_confirmation: '123456'
    }
    post  api_v1_sign_up_path, params: user_data.to_json, headers: header

    res = JSON.parse(response.body, symbolize_names: true)

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unprocessable_entity)
    expect(res[:data][:attributes].keys).to eq(%i[message])
    expect(res[:data][:attributes][:message]).to be_a_kind_of String
  end
end
