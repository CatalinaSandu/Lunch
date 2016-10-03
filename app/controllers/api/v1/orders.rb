module API
  module V1
    class Orders < Grape::API
      include API::V1::Defaults

      resource :orders do


        desc "checking code"
        params do
          requires :order_code, type: String
        end

        get :check_code do
          order_code = params[:order_code].split('-')
          order_id = order_code[0]
          dish1_id = order_code[1]

          if order_id.blank?
            {error_code: 401, error_message:"No order code."}
          elsif dish1_id.blank?
            {error_code: 401, error_message:"No order id."}
          end
          begin
            order = Order.where(id: order_id, dish1_id: dish1_id).first
          rescue
            order = nil
          end
          if order.nil?
            {error_code: 401, error_message:"No order."}
          else
            { order_id: order.id,
              first_dish: order.dish1_title,
              second_dish: order.dish2_title,
              dessert: order.dessert_title,
              order_status: order.order_status }
            end

          end

          desc "Return all orders"
          params do
            requires :date, type: Date
          end
          get "history", serializer: Order2Serializer  do
            date = params[:date]
            orders = Order.where(:created_at => DateTime.parse(date.to_s).beginning_of_day..DateTime.parse(date.to_s).end_of_day)
            return orders
          end

          desc "Create new order"
          params do
            requires :token, type: String
            requires :dish1_id, type: Integer
            optional :dish2_id, type: Integer
            optional :dessert_id, type: Integer
          end

          post "new" do
            token = params[:token]
            dish1_id = params[:dish1_id]
            dish2_id = params[:dish2_id]
            dessert_id = params[:dessert_id]

            menu = Menu.where("DATE(date) = ? ", Date.today)

            begin
              user = User.where(authentication_token: token).first!
            rescue
              user = nil
            end
            begin
              dish1 = Dish.where(id: dish1_id)
            rescue
              dish1 = nil
            end
            if user.nil?
              {error_code: 401, error_message:"No user found"}
            elsif token.blank?
              {error_code: 401, error_message:"Not authorized"}
            elsif dish1.nil?
              {error_code: 401, error_message: "Invalid dish1_id"}
            else
              order = Order.create!({
                user_id: user.id,
                dish1_id: dish1_id,
                dish2_id: dish2_id,
                dessert_id: dessert_id,
                order_status: "Pending"})

              UserMailer.delay.new_order(order)

              {success_message: "Order created"}
            end
          end


          desc "create rating"
          params do
            requires :rating, type: Integer
            requires :order_id, type: String
            requires :token, type: String
          end

          post "rating" do
            rating = params[:rating]
            order_id = params[:order_id]
            token = params[:token]
            begin
              user = User.where(authentication_token: token).first!
            rescue
              user = nil
            end
            begin
              order = Order.where(id: order_id).first!
            rescue
              order = nil
            end
            if token.blank?
              {error_code: 401, error_message:"Not authorized."}
            elsif order_id.blank?
              {error_code: 401, error_message:"No order choosen."}
            elsif user.nil?
              {error_code: 401, error_message:"No user found"}
            else
              order.rating = rating
              order.order_status = "Finished"
              order.save

              {
                order_status: "Finished"
              }
            end
          end

        end
      end
    end
  end
