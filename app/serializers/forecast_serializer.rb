class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current, :hourly, :daily, :city, :state, :country
end
