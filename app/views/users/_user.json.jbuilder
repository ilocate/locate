json.extract! user, :id, :username, :nickname, :phone, :encrypted_password, :sex, :age, :bio, :avatar, :state, :setting, :created_at, :updated_at
json.url user_url(user, format: :json)
