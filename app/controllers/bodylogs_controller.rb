class BodylogsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json
  
	def index
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at', per_page: 5
		@bodylogsCal = @user.bodylogs.find(:all)
		@date = params[:month] ? Date.parse(params[:month]) : Date.today
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

	private

		def bodylog_params
			params.require(:bodylog).permit(:weight, :bodyfat, :kcal)
		end

end
