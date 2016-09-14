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
            Menu.where("DATE(date) = ?", Date.today)
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
