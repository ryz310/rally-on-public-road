json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :user_id, :name, :acquisition_date, :profile
  json.url vehicle_url(vehicle, format: :json)
end
