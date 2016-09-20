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

      user = User.where(authentication_token: permitted_params[:token]).first!
      {name: user.name,
        email: user.email,
        address: user.address,
        phone: user.phone}
      end


      desc "Edit profile"
      params do
        requires :token, type: String
        requires :avatar, :type => Rack::Multipart::UploadedFile
        requires :name, type: String
        requires :email, type: String
        requires :phone, type: String
        requires :address, type: String
      end

      put 'edit' do
        avatar = params[:avatar]

        attachment = {
          :filename => avatar[:filename],
          :type => avatar[:type],
          :headers => avatar[:head],
          :tempfile => avatar[:tempfile]
        }

        User.find_by_authentication_token(params[:token]).update({
          avatar: ActionDispatch::Http::UploadedFile.new(attachment),
          name:params[:name],
          email:params[:email],
          phone:params[:phone],
          address:params[:address]})

        {success_message: "Create profile"}

      end


    end
  end
end
end
