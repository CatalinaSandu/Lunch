module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

       resource :users do
      #   desc "Return all users"
      #   get "", root: :users do
      #     User.all
      #   end

        desc "Create new user"
        params do
          requires :name, type: String
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
          requires :phone, type: String
          requires :address, type: String
        end

        post "sign_up" do

          User.create({
            name:params[:name],
            email:params[:email],
            password:params[:password],
            password_confirmation:params[:password_confirmation],
            phone:params[:phone],
            address:params[:address]})

            {success_message: "User created"}
        end

        desc "Log in user"
        params do
          requires :email, type: String
          requires :password, type: String
        end

        post "log_in" do
          email = params[:email]
          password = params[:password]

          if email.nil? or password.nil?
            error!({error_code: 404, error_message: 'Invalid Email or Password.'}, 401)
            return
          end

          user = User.where(email: email.downcase).first
          if user.nil?
            error!({error_code: 404, error_message: 'NO user.'}, 401)
            return
          end

          if !user.valid_password?(password)
            error!({error_code: 404, error_message: 'Invalid Password.'}, 401)
            return
          else
           user.ensure_authentication_token
           user.save
           {status: 'ok', auth_token: user.authentication_token}
           end
         end


         desc "Edit profile"
         params do
          requires :token, type: String
          #requires :avatar, type: image
          requires :name, type: String
          requires :email, type: String
          # requires :password, type: String
          # requires :password_confirmation, type: String
          # requires :current_password, type: String
          requires :phone, type: String
          requires :address, type: String
          end

          put 'edit' do
            User.find_by_authentication_token(params[:token]).update({
            name:params[:name],
            email:params[:email],
            # password:params[:password],
            # password_confirmation:params[:password_confirmation],
            # current_password:params[:current_password],
            phone:params[:phone],
            address:params[:address]})

            {success_message: "Create profile"}


          end


     end

   end
 end
end
