require 'rails_helper'
RSpec.describe BackgroundImageData do
  it 'have attributes' do
    data = JSON.parse(File.read('spec/data/image_data.json'), symbolize_names: true)

    image_data = BackgroundImageData.new(data)
    expect(image_data).to be_instance_of BackgroundImageData
    expect(image_data.credit_to).to eq(data[:results][0][:user][:name])
    expect(image_data.image_url).to eq(data[:results][0][:urls][:raw])
  end
end
