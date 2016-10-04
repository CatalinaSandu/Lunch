class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 def facebook
  omniauth = request.env["omniauth.auth"]
  session[:fb_token] = omniauth["credentials"]["token"] if omniauth['provider'] == 'facebook'

  @user = User.from_omniauh(request.env["omniauth.auth"])
  if @user.persisted?
    sign_in_and_redirect @user, :event => :authentication
  else
    session["devise.facebook_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_path
  end
end
end
