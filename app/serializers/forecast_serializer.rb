class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :city, :state, :country, :current, :hourly, :daily
end
