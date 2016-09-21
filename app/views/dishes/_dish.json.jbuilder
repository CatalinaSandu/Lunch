json.extract! dish, :id, :dish_title, :dish_type, :menu_id, :created_at, :updated_at
json.url dish_url(dish, format: :json)