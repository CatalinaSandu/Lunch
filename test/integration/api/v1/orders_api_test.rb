require 'test_helper'
require 'json'

class OrdersApiTest < ActionDispatch::IntegrationTest
  fixtures :menus

  def setup
   post "/api/v1/users/sign_up",
   { name: "catalina sandu",
    email: "sanducatalina@yahoo.com",
    password: "catalinas",
    password_confirmation: "catalinas",
    phone: "0757329609",
    address: "Dumbraveni" }
    assert_equal 201, status

    post "/api/v1/users/log_in", {email: "sanducatalina@yahoo.com", password: "catalinas"}
    assert_equal 201, status

    @token = JSON.parse(@response.body)['auth_token']
  end

  def test_post_new_order
    post "/api/v1/orders/new", {menu_id: menus(:one).id, token: @token}
    assert_equal 201, status
    assert_equal menus(:one).id, JSON.parse(@response.body)['menu']['id']
  end


end
