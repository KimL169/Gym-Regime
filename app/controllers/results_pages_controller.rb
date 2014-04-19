class ResultsPagesController < ApplicationController
	include ResultsPagesHelper
	before_action :signed_in_user #check if user = signed in.
	respond_to :html, :json # necessary for in_place_editing.


	##########
	# Index page controller for combined Bodylog and Workoutlog records.
	##########
	def index
		#variables to isplay bodylogs records
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at DESC', per_page: 7 #display 7 results per page in descending order.
		@bodylogs = @user.bodylogs.find(:all, order: :created_at) # find all bodylogs in the order-of created at (so chart will display well upon editing.)
		@date = params[:month] ? Date.parse(params[:month]) : Date.today  # for the calendar date selector
		@profile = @user.profile

		gon.weight = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.weight]} #collect db data to pass to Javascript chart
		gon.kcal = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.kcal]} #collect db data to pass to Javascript chart
		
		#variables/arrays to display workout records. 
		@exercises = get_exercise_list(@user.exercises.all) #see results_pages_helper for 'get_exercise_list' method
		@workouts = @user.workouts.all
		@workoutsTable = @user.workouts.paginate page: params[:page], order: 'created_at DESC', per_page: 7
		@strengthList = get_strength(params[:exercise])	#see results_pages_helper for 'get_strength' method
		gon.strength =  @strengthList.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.strength]}  #collect db data to pass to Javascript chart

		if params[:exercise] != nil #To provide graph with the proper name
			gon.exercise_name = params[:exercise] 
		else
			gon.exercise_name = '-' #if no workout selected
		end 
	end
end