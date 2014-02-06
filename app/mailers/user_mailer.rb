class UserMailer < ActionMailer::Base
	#####
	# Mailer class to send email confirmation message
	#####

  default from: "krelandeweer@gmail.com"

  def welcome_email(user)
  	@user = user
  	@url = 'http://example.com/login'
  	mail(to: @user.email, subject: 'Welcome to the workout book!')
  end
end
