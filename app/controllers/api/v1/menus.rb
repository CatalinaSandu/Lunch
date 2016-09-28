module API
  module V1
    class Menus < Grape::API
      include API::V1::Defaults

      resource :menus do

        desc "Return all menus by current day"
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
            return menus
          else
            {error_code: 401, error_message:"Not authorized."}
          end
        end

        desc "Return all menus"
        get "history" do
          menus = Menu.all
          return menus
        end
      end
    end
  end
end
