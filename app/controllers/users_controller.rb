class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update] #make sure only signed in users can update their account
	before_action :correct_user, only: [:edit, :update] #make sure only the correct user can update their account.

	#####
	# Initialize a new user for the sign up form
	####!
	def new
		@user = User.new
	end

	#####
	# Edit account page
	####
	def edit 
	end

	#####
	# Update action for the edit account page
	####
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Account updated!"
			redirect_to user_profile_path(:user_id => @user)
		else
			render 'edit'
		end
	end

	#######
	# Create a new user when sign-up form is submitted
	#######
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the WorkoutBook #{@user.name}!"
			redirect_to new_user_profile_path(:user_id => @user)
		else
			render 'new'
		end
	end

	private
	
		#####
		# Secure paramaters for user sign-up (For sign-in see sessions_controller)
		#####
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# before filters

		#####
		# Check if correct user before any controller action.
		#######
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end
end
