class BackgroundImageData
  attr_reader :image_url, :credit_to, :id
  def initialize(data)
    @credit_to = data[:results][0][:user][:name]
    @image_url = data[:results][0][:urls][:raw]
  end
end
