class WorkoutsController < ApplicationController
	include WorkoutsHelper
  before_action :signed_in_user
  respond_to :html, :json

	def new
		@user = current_user
		@workout = @user.workouts.new
		@exercise = @workout.exercises.build
		@segment = @exercise.segments.build
	end

	def index
		@user = current_user
		@workouts = @user.workouts.all
		#@workoutsTable = @workouts.paginate page: params[:page], order: 'created_at', per_page: 10
	end

	def create
		@user = current_user
		@workout = @user.workouts.new(workout_params)
		if @workout.save
			get_max(@workout) #helper method to calculate one_rep_max per exercise
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

	def destroy
	end

	def show
	end
	
	private

	def workout_params
		params.require(:workout).permit(:name, :comment, exercises_attributes: [:name, :comment, segments_attributes: [:weight, :reps, :intensity]])
	end
end


