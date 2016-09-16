require 'test_helper'
require 'json'

class MenusApiTest < ActionDispatch::IntegrationTest
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

  def test_get_all_menus
    get "/api/v1/menus", {token: @token}
    assert_equal 200, status
  end

end
