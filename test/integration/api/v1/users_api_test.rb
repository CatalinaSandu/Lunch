require 'test_helper'
require 'json'

class UsersApiTest < ActionDispatch::IntegrationTest
  fixtures :users

  def test_get_all_users
    #get the login page
    get "/api/v1/users"
    assert_equal 200, status
    users = JSON.parse(@response.body)
    assert_equal 2, users.length
  end

  def test_post_user_sign_up_and_log_in
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

  end


end

