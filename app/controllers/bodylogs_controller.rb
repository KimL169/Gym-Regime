class BodylogsController < ApplicationController
	include BodylogsHelper
	before_action :signed_in_user
	respond_to :html, :json

	def update
		@user = current_user
		@bodylog = @user.bodylogs.find(params[:id])
		@bodylog.update_columns(bodylog_params)
		respond_with @bodylog
	end

	def new
		@user = current_user
		@bodylog = @user.bodylogs.new
	end

	def create
		@user = current_user
		@bodylog = @user.bodylogs.new(bodylog_params)
		if @bodylog.save
			flash.now[:success] = "Log entry succesful!"
			redirect_to '/results'
      	else
        	render :new
		end
	end

	def destroy
		@user = current_user
		@bodylog = @user.bodylogs.find(params[:id])
		@bodylog.destroy
		flash[:success] = "Log entry date: #{@bodylog.created_at.strftime('%m/%d/%Y')} deleted "
		redirect_to '/results'
	end

	private

		def bodylog_params
			params.require(:bodylog).permit(:weight, :bodyfat, :kcal, :created_at)
		end

end
