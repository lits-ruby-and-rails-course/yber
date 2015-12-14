json.array!(@orders) do |order|
  json.extract! order, :id, :rider_id, :order_id, :location_to, :location_from, :status, :price, :description
  json.url order_url(order, format: :json)
end
