require 'rails_helper'

RSpec.describe JsonWebToken do
  it 'should have a pay load' do
    encoded_token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.p_b_S6hwo6_pYbJeG-Wtv4ZAur6nQGwRWVCk3594lXI'
    stub = class_double('JsonWebToken').as_stubbed_const(transfer_nested_constants: true)
    expect(stub).to receive(:encode).and_return(encoded_token)

    pay_load = { user_id: 1 }
    expect(JsonWebToken.encode(pay_load)).to eq(encoded_token)
  end
end
# TODO: Continue with the test
# TODO: Test not complete
