class Users::SessionsController < Devise::SessionsController

  def destroy
    super
    session[:fb_token] = nil
    session.clear
  end

end
