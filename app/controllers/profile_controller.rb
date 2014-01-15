class ProfileController < ApplicationController
	before_action :signed_in_user
	respond_to :html, :json

	def new
		@user = current_user
		@profile = @user.build_profile
	end

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

	def show
		@user = current_user
		@profile = @user.profile
	end

	def update
		@user = current_user
		@profile = @user.profile
		@profile.update_columns(profile_params)
		respond_with @profile
	end

	def destroy
	end

	private

		def profile_params
			params.require(:profile).permit(:age, :height, :gender)
  		end
end
