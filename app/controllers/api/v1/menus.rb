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
            menus = Menu.where("DATE(date) = ?", Date.today)
          #   menu_array = []
          #   menus.each do |m|
          #   menu_array <<
          #   {
          #     id: m.id,
          #     title: m.title,
          #     restaurant_name: m.restaurant.name,
          #     first_dish_options: m.dishes.select { |d| d.dish_type == 'First' },
          #     picture_first_dish: "http://#{request.host_with_port}#{m.dishes.first.picture.url}",
          #     second_dish: m.dishes.second.dish_title,
          #     picture_second_dish: "http://#{request.host_with_port}#{m.dishes.second.picture.url}",
          #     dessert: m.dishes.last.dish_title,
          #     picture_dessert: "http://#{request.host_with_port}#{m.dishes.last.picture.url}",
          #   }
          # end
          # byebug
          return menus

        else
          {error_code: 401, error_message:"Not authorized."}
        end
      end

      desc "Return a menu"
      params do
        requires :id, type: String, desc: "ID of the menu"
      end
      get ":id", root: "menu" do
        menu=Menu.where(id: permitted_params[:id]).first!
        return menu
      end
    end
  end
end
end
