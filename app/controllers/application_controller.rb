class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  add_flash_types :success, :warning, :danger, :info

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def refresh_dish_selection
    @dishes = Dish.where(menu_id: params[:menu_id])
  end

  def facebook_logout
    split_token = session[:fb_token].split("|")
    fb_api_key = split_token[0]
    fb_session_key = split_token[1]
    redirect_to "http://www.facebook.com/logout.php?api_key=#{fb_api_key}&session_key=#{fb_session_key}&confirm=1&next=#{destroy_user_session_url}";
    session.clear
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :phone, :address) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :phone, :address, :avatar) }
  end

end
