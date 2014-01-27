class BodylogsController < ApplicationController
	include BodylogsHelper
	before_action :signed_in_user
	respond_to :html, :json

	def index
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at DESC', per_page: 5
		@bodylogs = @user.bodylogs.all
		@date = params[:month] ? Date.parse(params[:month]) : Date.today  # for the calendar date selector
		@profile = @user.profile
		gon.weight = []
		gon.kcal = []
		@bodylogs.each {|e| gon.weight.append(e.weight)}
		@bodylogs.each {|e| gon.kcal.append(e.kcal)}
		@exercises = @user.exercises.all
		gon.strength = get_strength(@exercises)
		gon.days_ago = get_days_ago(@bodylogs)
		gon.created_at = []
		@bodylogs.each { |e| gon.created_at.append(e.created_at)}
	end

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
			redirect_to action: "index"
      	else
        	render :new
		end
	end

	def destroy
		@user = current_user
		@bodylog = @user.bodylogs.find(params[:id])
		@bodylog.destroy
		redirect_to action: 'index'
	end

	private

		def bodylog_params
			params.require(:bodylog).permit(:weight, :bodyfat, :kcal, :created_at)
		end

end
