json.array!(@reviews) do |review|
  json.extract! review, :id, :type, :rider_id, :driver_id, :stars, :text
  json.url review_url(review, format: :json)
end
