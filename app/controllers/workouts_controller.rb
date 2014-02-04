class WorkoutsController < ApplicationController
	include WorkoutsHelper
	  before_action :signed_in_user
	  respond_to :html, :json

	def new
		@user = current_user
		@workout = @user.workouts.new
		@exercise = @workout.exercises.build
		@exercise.user_id = current_user.id
		@segment = @exercise.segments.build
	end

	def create
		@user = current_user
		@workout = @user.workouts.build(workout_params)
		if @workout.save
			@workout.exercises.each do |e| 
			e.segments.each do |s|
				s.workout_id = @workout.id
			end
		end
		@workout.save
		get_max(@workout) #helper method to calculate one_rep_max per exercise
		flash.now[:success] = "Log entry succesful!"
		redirect_to '/results'
      	else
        	render :new
		end
	end

	def edit
		@user = current_user
		@workout = @user.workouts.find(params[:id])
	end

	def update
		@user = current_user
		@workout = @user.workouts.find(params[:id])
		if @workout.update_attributes(workout_params)
			# update the created_at of all the exercises and segments belonging to the workout.
			@exercises = @workout.exercises.all
			@exercises.each do |e|
				e.update_columns(:created_at => @workout.created_at)
				e.segments.each do |s|
					s.update_columns(:created_at => @workout.created_at)
				end
			end
			flash[:success] = "Workout updated!"
			redirect_to '/results'
		else
			render 'edit'
		end
	end

	def destroy
		@user = current_user
		@workout = @user.workouts.find(params[:id])
		@workout.destroy
		flash[:success] = "Workout: #{@workout.name} - #{@workout.created_at.strftime('%m/%d/%Y')} was deleted."
		redirect_to '/results'
	end


	def show
	end
	
	private

		def workout_params
			params.require(:workout).permit(:name, :comment, :rating, :created_at, 
											exercises_attributes: [:id, :name, :comment, :user_id, :created_at, :updated_at, 
											segments_attributes: [:id, :weight, :reps, :intensity, :created_at, :updated_at, :workout_id]])
		end
end


