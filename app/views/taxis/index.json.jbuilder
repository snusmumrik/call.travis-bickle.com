json.array!(@taxis) do |taxi|
  json.extract! taxi, :id, :user_id, :name, :type
  json.url taxi_url(taxi, format: :json)
end
