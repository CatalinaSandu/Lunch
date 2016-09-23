json.extract! order, :id, :order_status, :rating, :dish1_id, :dish2_id, :dessert_id, :menu_id, :created_at, :updated_at
json.url order_url(order, format: :json)