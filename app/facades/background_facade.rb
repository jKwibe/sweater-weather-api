class BackgroundFacade
  attr_reader :id
  def initialize(location)
    @location = location
  end

  def api_data
    BackgroundService.image_data(@location)
  end

  def image_data
    BackgroundImageData.new(api_data)
  end

  def credit_to
    image_data.credit_to
  end

  def image_url
    image_data.image_url
  end
end
