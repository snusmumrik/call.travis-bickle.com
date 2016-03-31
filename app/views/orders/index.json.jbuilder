json.array!(@orders) do |order|
  json.extract! order, :id, :address, :latitude, :longitude, :keyword, :assigned_at, :picked_up_at, :arrived_at
  json.url order_url(order, format: :json)
end
