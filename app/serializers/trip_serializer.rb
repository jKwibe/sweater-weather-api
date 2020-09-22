class TripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :destination_temperature, :destination_weather_desc, :time_taken
end
