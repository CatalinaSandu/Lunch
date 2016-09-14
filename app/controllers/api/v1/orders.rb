module API
  module V1
    class Orders < Grape::API
      include API::V1::Defaults

      resource :orders do
        desc "Return all orders"
        get "", root: :orders do
          Order.all
        end

        desc "Return a order"
        params do
          requires :id, type: String, desc: "ID of the
          order"
        end

        get ":id", root: "order" do
          Order.where(id: permitted_params[:id]).first!
        end

        desc "Create new order"
        params do
          requires :menu_id, type: String
          requires :token, type: String
        end

        post "new" do
          menu_id = params[:menu_id]
          token = params[:token]
          begin
            user = User.where(authentication_token: token).first!
          rescue
            user = nil
          end
          begin
            menu = Menu.where(id: menu_id).first!
          rescue
            menu = nil
          end
          if user.nil?
            {error_code: 401, error_message:"No user found"}
          elsif token.blanck?
            {error_code: 401, error_message:"Not authorized"}
          elsif menu.nil?
            {error_code: 401, error_message:"No menu found"}
          elsif menu_id.blanck?
            {error_code: 401, error_message:"No menu choosen"}
          else
            order = Order.create!({
              menu_id: menu_id,
              user_id: user.id,
              order_status: "Pending"})
          end
        end

      end
    end
  end
end
