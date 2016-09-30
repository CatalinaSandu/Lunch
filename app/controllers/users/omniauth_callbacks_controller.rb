class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauh(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end
