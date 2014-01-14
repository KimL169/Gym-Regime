class WorkoutlogsController < ApplicationController
  before_action :signed_in_user

	def new
		@user = current_user
		@workout = @user.workouts.new
		@exercise = @workout.exercises.new
	end

	def index
	end

	def create
		@user = current_user
		@workout = @user.workouts.new(workout_params)
		@workout.save
		@exercise = @workout.exercises.new(exercise_params)
		@exercise.save
		@segment = @exercise.segments.new(segment_params)
		@segment.save
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
