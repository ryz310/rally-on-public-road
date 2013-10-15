json.array!(@users) do |user|
  json.extract! user, :name, :birthday, :prefecture_id, :profile
  json.url user_url(user, format: :json)
end
