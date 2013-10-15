json.array!(@check_points) do |check_point|
  json.extract! check_point, :event_id, :number, :latitude, :longitude, :note
  json.url check_point_url(check_point, format: :json)
end
