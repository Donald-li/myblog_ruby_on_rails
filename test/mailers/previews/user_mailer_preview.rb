class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_emailer(User.first)
  end
end