json.extract! order, :id, :order_status, :menu_id, :user, :created_at, :updated_at
json.url order_url(order, format: :json)