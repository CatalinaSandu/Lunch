class UserMailer < ActionMailer::Base
  default from: "internship@assist.ro"
  def send_enabled_message(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Assist Workshop!")
  end

  def new_registration(user)
    @user = user
    mail(:to => ['catalina.sandu@assist.ro', user.email], :subject => "Welcome to Lunch App!")
  end

  def new_order(order)
    @order = order
    mail(:to => order.user.email, :subject => "New order!")
  end
end
