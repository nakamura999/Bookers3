class ThanksMailer < ApplicationMailer
  def send_mail(user)
    @user = user
	mail to: user.email, subject: 'Welcome to Our Application!'
  end
end
