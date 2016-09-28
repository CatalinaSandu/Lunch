module API
  module V1
    class Menus < Grape::API
      include API::V1::Defaults

      resource :menus do

        desc "Return all menus"
        params do
          requires :token, type: String
          requires :date, type: Date
        end
        get "", root: :menus do
          token = params[:token]
          date = params[:date]
          begin
            user = User.where(authentication_token: token).first!
          rescue
            user = nil
          end
          if user
            menus = Menu.where("DATE(date) = ?", date)
            return menus

          else
            {error_code: 401, error_message:"Not authorized."}
          end
        end

        desc "Return a menus history"

        get "history", serializer: Menu2Serializer do

         menus = Menu.all
         return menus

       end

     end
   end
 end
end
