require 'rails_helper'

RSpec.describe JsonWebToken do
  it 'should have a pay load' do
    pay_load = { user_id: 1 }
    expect(JsonWebToken.encode(pay_load).size).to eq(117)
    expect(JsonWebToken.encode(pay_load)).to be_a_kind_of(String)
  end

  it 'should can decode' do
    token = JsonWebToken.encode({ user_id: 1 })
    expect(JsonWebToken.decode(token)).to be_a Integer
  end

  it 'should return nil if not decoded' do
    token = JsonWebToken.encode({ user_id: 1 }) << 'a'
    expect(JsonWebToken.decode(token)).to be_nil
  end
end
