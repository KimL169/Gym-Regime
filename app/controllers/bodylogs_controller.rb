class BodylogsController < ApplicationController
  before_action :signed_in_user
  
	def index
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at', per_page: 5
		@bodylogsCal = @user.bodylogs.find(:all)
		@date = params[:month] ? Date.parse(params[:month]) : Date.today
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
		end
	end

	private

		def bodylog_params
			params.require(:bodylog).permit(:weight, :bodyfat, :kcal)
		end

end
