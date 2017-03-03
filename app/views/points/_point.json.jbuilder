json.extract! point, :id, :track_id, :latitude, :longitude, :address, :created_at, :updated_at
json.url point_url(point, format: :json)
