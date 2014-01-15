class WorkoutsController < ApplicationController
  before_action :signed_in_user
  respond_to :html, :json

	def new
		@user = current_user
		@workout = @user.workouts.new
	end

	def index
		@user = current_user
		@workoutsTable = @user.workouts.paginate page: params[:page], order: 'created_at', per_page: 10
	end

	def create
		@user = current_user
		@workout = @user.workouts.new(workout_params)
		if @workout.save
			flash.now[:success] = "Log entry succesful!"
			redirect_to action: "index"
      	else
        	render :new
		end
	end

	def update
		@user = current_user
		@workout = @user.workouts.find(params[:id])
		@workout.update_columns(workout_params)
		respond_with @workout
	end

	def show
	end
	
	private

	def workout_params
		params.require(:workout).permit(:name, :comment)
	end

	def exercise_params
		params.require(:exercise).permit(:name, :comment)
	end

	def segment_params
		params.require(:segment).permit(:weight, :reps, :intensity)
	end

end


