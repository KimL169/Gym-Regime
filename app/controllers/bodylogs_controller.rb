class BodylogsController < ApplicationController
	include BodylogsHelper
	before_action :signed_in_user
	respond_to :html, :json

	##################
	# Update an existing bodylog using best_in_place
	#################
	def update
		@user = current_user
		@bodylog = @user.bodylogs.find(params[:id])
		@bodylog.update_columns(bodylog_params)
		respond_with @bodylog
	end

	###################
	#initialize a new bodylog form 
	###################
	def new
		@user = current_user
		@bodylog = @user.bodylogs.new
		@bodylogscount = @user.bodylogs.count #count method to see how long to display information panel
	end

	##################
	# Create a new bodylog when form is entered.
	#################
	def create
		@user = current_user
		@bodylog = @user.bodylogs.new(bodylog_params)
		@bodylogscount = @user.bodylogs.count
		if @bodylog.save
			@bodylog.updated_at = @bodylog.created_at #this is for chart display using updated_at exclusively.
			flash.now[:success] = "Log entry succesful!"
			redirect_to '/results' 
      	else
      		flash.now[:success] = "You can only save one bodylog a day.
      						Please edit your existing bodylog or adjust the date." 
        	render :new
		end
	end

	################
	# Delete a bodylog record from the database
	################
	def destroy
		@user = current_user
		@bodylog = @user.bodylogs.find(params[:id])
		@bodylog.destroy
		flash.now[:success] = "Log entry date: #{@bodylog.created_at.strftime('%m/%d/%Y')} deleted "
		redirect_to '/results'
	end

	private

		#######
		# Secure parameters for bodylog form
		#######
		def bodylog_params
			params.require(:bodylog).permit(:weight, :bodyfat, :kcal, :created_at, :updated_at)
		end

end
