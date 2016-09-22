module API
  module V1
    class Menus < Grape::API
      include API::V1::Defaults

      resource :menus do

        desc "Return all menus"
        params do
          requires :token, type: String
        end
        get "", root: :menus do
          token = params[:token]
          begin
            user = User.where(authentication_token: token).first!
          rescue
            user = nil
          end
          if user
            menu = Menu.where("DATE(date) = ?", Date.today).first!
            {
              title: menu.title,
              restaurant_name: menu.restaurant.name,
              first_dish: menu.dishes.first.dish_title,
              picture_first_dish: "http://#{request.host_with_port}#{menu.dishes.first.picture.url}",
              second_dish: menu.dishes.second.dish_title,
              picture_second_dish: "http://#{request.host_with_port}#{menu.dishes.second.picture.url}",
              dessert: menu.dishes.last.dish_title,
              picture_dessert: "http://#{request.host_with_port}#{menu.dishes.last.picture.url}",
            }
          else
            {error_code: 401, error_message:"Not authorized."}
          end
        end

        desc "Return a menu"
        params do
          requires :id, type: String, desc: "ID of the menu"
        end
        get ":id", root: "menu" do
          Menu.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
