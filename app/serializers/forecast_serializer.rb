class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current, :hourly, :daily
end
