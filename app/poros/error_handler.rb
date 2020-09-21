class ErrorHandler
  attr_reader :id
  def initialize(error)
    @error = error
  end

  def message
    if @error.class == String
      @error
    else
      @error.message
    end
  end
end
