class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :message
end
