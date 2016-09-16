class RegisterController < Devise::RegistrationsController
 def create
   super
   if @user.persisted?
      UserMailer.delay.new_registration(@user)
   end
 end
 private
end
