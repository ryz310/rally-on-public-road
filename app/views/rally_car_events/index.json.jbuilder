json.array!(@rally_car_events) do |rally_car_event|
  json.extract! rally_car_event, :name, :beginning_on, :end_on, :note
  json.url rally_car_event_url(rally_car_event, format: :json)
end
