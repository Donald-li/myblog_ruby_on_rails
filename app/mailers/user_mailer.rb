class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def welcome_emailer(user)
    @user = user
    @url  = '1026619991@qq.com'
    mail(to: @url, subject: 'Welcome to My Awesome Site')

  end
end
