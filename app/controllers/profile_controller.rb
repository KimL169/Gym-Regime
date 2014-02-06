class ProfileController < ApplicationController
	include ProfileHelper # get the helper methods for the profile.
	before_action :signed_in_user #make sure the user is signed in.
	respond_to :html, :json #necessary for best_in_place edition

	########
	# initialize a new profile form for the new user
	#######
	def new
		@user = current_user
		@profile = @user.build_profile
	end

	##########
	# Create the profile upon submission of form
	#########
	def create
		@user = current_user
		@profile = @user.build_profile(profile_params) 
		if @profile.save
			flash[:success] = "Profile successfully created!"
			redirect_to user_profile_path(@user)
		else
			flash[:notice] = 'Error: something went wrong.'
			render :action => "new" 
		end
	end

	##########
	# Render the user profile 'show' page.
	###########
	def show
		@user = current_user
		@profile = @user.profile
		@bodylog = @user.bodylogs.find(:last)
		@bodylogs = @user.bodylogs.order('created_at DESC').all #necessary for the calculators
	end

	###########
	# Update the profile using best_in_place editing 
	###########
	def update
		@user = current_user
		@profile = @user.profile
		@profile.update_columns(profile_params)
		respond_with @profile 
	end

	private
		########
		# Secure parameters for user profile.
		#######
		def profile_params
			params.require(:profile).permit(:age, :height, :gender, :activity, :caltarget, :weighttarget, :changerate)
  		end

end
