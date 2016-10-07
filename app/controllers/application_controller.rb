class ApplicationController < ActionController::Base
  require 'one_signal'

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  add_flash_types :success, :warning, :danger, :info

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def refresh_dish_selection
    @dishes = Dish.where(menu_id: params[:menu_id])
  end

  def facebook_logout
    # split_token = session[:fb_token].split("|")
    # fb_api_key = split_token[0]
    # fb_session_key = split_token[1]
    fb_api_key = '1718333038491869'
    fb_session_key = session[:fb_token]
    redirect_to "http://www.facebook.com/logout.php?api_key=#{fb_api_key}&session_key=#{fb_session_key}&confirm=1";
    session.clear
  end

  OneSignal::OneSignal.api_key = "ZjE0MGVlZDgtY2YxNS00MjkzLWE4ZTQtZDUxZTUwMmJjMTZh"
  OneSignal::OneSignal.user_auth_key = "MDEwODZjMzMtMzdjMi00YmNkLTg5ZDItN2NlMmU5NzBmNDM3"

  def one_signal_push_notification(device_token, message)
    params = {
      app_id: "6d861ad6-3ad3-4bce-b512-68a57055cb25",
      contents: { en: message},
      include_player_ids: [device_token]
    }
    begin
      response = OneSignal::Notification.create(params: params)
      notification_id = JSON.parse(response.body)["id"]
    rescue OneSignal::OneSignalError => e
      puts "--- OneSignalError  :"
      puts "-- message : #{e.message}"
      puts "-- status : #{e.http_status}"
      puts "-- body : #{e.http_body}"
    end

  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :phone, :address) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :phone, :address, :avatar) }
  end

end
