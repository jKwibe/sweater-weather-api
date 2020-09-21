class ErrorHandler
  attr_reader :id, :message
  def initialize(error)
    @message = error.message
  end
end
