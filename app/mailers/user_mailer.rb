class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome(user)
    @user = user
    @url = "http://localhost:3000/users/sign_in"
    mail(to: @user.email, subject: "hello world")
  end
end
