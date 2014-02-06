class WorkoutsController < ApplicationController
	include WorkoutsHelper
	  before_action :signed_in_user
	  respond_to :html, :json

	#######
	# Initialize a new workout when rendering the log entry page.
	#######
	def new
		@user = current_user
		@workout = @user.workouts.new
		@exercise = @workout.exercises.build
		@exercise.user_id = current_user.id
		@segment = @exercise.segments.build
	end

	########
	# Create a new workout on submission of forms: using nested attributes for exercises and segments
	########
	def create
		@user = current_user
		@workout = @user.workouts.build(workout_params)
		if @workout.save
			@workout.exercises.each do |e| 
			e.segments.each do |s|
				s.workout_id = @workout.id #Ad workout id to each segment to link segments to a workout 
			end
		end
		@workout.save
		get_max(@workout) #helper method to calculate one_rep_max per exercise, will add strength stats to workouts/segments
		flash.now[:success] = "Log entry succesful!"
		redirect_to '/results'
      	else
        	render :new
		end
	end

	########
	# Render the edit page to update a workout.
	########
	def edit
		@user = current_user
		@workout = @user.workouts.find(params[:id])
	end

	#########
	# Method to update a workout with belonging exercises and segments.
	#########
	def update
		@user = current_user
		@workout = @user.workouts.find(params[:id])
		if @workout.update_attributes(workout_params)
			# update the created_at of all the exercises and segments belonging to the workout.
			@exercises = @workout.exercises.all
			#make sure the date of the exercises and segments is updated as well to get correct chart information.
			@exercises.each do |e|  
				e.update_columns(:created_at => @workout.created_at)
				e.segments.each do |s|
					s.update_columns(:created_at => @workout.created_at)
				end
			end
			get_max(@workout) # reestablish strength levels.
			flash[:success] = "Workout updated!"
			redirect_to '/results'
		else
			render 'edit'
		end
	end

	#########
	# delete a workout and the exercises and segments belonging to it.
	#########
	def destroy
		@user = current_user
		@workout = @user.workouts.find(params[:id])
		@workout.destroy
		flash[:success] = "Workout: #{@workout.name} - #{@workout.created_at.strftime('%m/%d/%Y')} was deleted."
		redirect_to '/results'
	end
	
	private
		########
		# Secure params for workout with nested attributes for exercises and segments so they can be submitted using the same form.
		########
		def workout_params
			params.require(:workout).permit(:name, :comment, :rating, :created_at, 
											exercises_attributes: [:id, :name, :comment, :user_id, :created_at, :updated_at, 
											segments_attributes: [:id, :weight, :reps, :intensity, :created_at, :updated_at, :workout_id]])
		end
end


