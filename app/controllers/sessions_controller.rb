class SessionsController < ApplicationController

	#######
	# Initialize a new session
	#######
	def new
		render 'new'
	end

	#########
	# Create a new user session: user sign in.
	#########
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user_profile_path(:user_id => user) #back to the page he tried to view but got refused access or to his profile.
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	#########
	# destroy session: sign out the user and return to sign-up/in page.
	########
	def destroy
		sign_out
		redirect_to  root_url
	end
end
