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

     desc "Status token"
     params do
      requires :token, type: String
    end

    get 'status' do

      user = User.where(authentication_token: permitted_params[:token]).first!
      if user.expired?
        {status: 'invalid'}
      else
        {status: 'valid'}

      end
    end

    desc "Profile"
    params do
      requires :token, type: String
    end

    get 'profile' do
      user = User.find_by_authentication_token(permitted_params[:token])
      { avatar: user.avatar,
        name: user.name,
        email: user.email,
        address: user.address,
        phone: user.phone}

      end


      desc "Edit profile"
      params do
        requires :token, type: String
        optional :avatar, :type => Rack::Multipart::UploadedFile
        optional :name, type: String
        #optional :email, type: String
        optional :phone, type: String
        optional :address, type: String
      end


      put 'edit' do
        user = User.find_by_authentication_token(permitted_params[:token])
        if params[:avatar]

          avatar = params[:avatar]

          attachment = {
            :filename => avatar[:filename],
            :type => avatar[:type],
            :headers => avatar[:head],
            :tempfile => avatar[:tempfile]
          }
          user.avatar = ActionDispatch::Http::UploadedFile.new(attachment)

        end

        permitted_params.delete :token
        permitted_params.delete :avatar

        user.update_attributes(permitted_params.to_h)

        {success_message: "Updated profile"}

      end

    end
  end
end
end
