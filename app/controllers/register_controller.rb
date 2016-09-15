class RegisterController < Devise::RegistrationsController

 def create
   super
   if @user.persisted?
      UserMailer.delay.new_registration(@user)
   end
 end
 private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:phone,:address)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password,:phone,:address)
  end
end
