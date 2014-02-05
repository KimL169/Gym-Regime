class ResultsPagesController < ApplicationController
	include ResultsPagesHelper
	include ApplicationHelper
	before_action :signed_in_user
	respond_to :html, :json

	def index
		#bodylogs
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at DESC', per_page: 7
		@bodylogs = @user.bodylogs.find(:all, order: :created_at)
		@date = params[:month] ? Date.parse(params[:month]) : Date.today  # for the calendar date selector
		@profile = @user.profile
		gon.weight = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.weight]} #collect db data to pass to Javascript chart
		gon.kcal = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.kcal]} #collect db data to pass to Javascript chart

		#workouts
		@exercises = get_exercise_list(@user.exercises.all)
		@workouts = @user.workouts.all
		@workoutsTable = @user.workouts.paginate page: params[:page], order: 'created_at DESC', per_page: 7
		@strengthList = get_strength(params[:exercise])

		if params[:exercise] != nil 
			gon.exercise_name = params[:exercise] #provide graph with the proper name
		else
			gon.exercise_name = '-'
		end 
		gon.strength =  @strengthList.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.strength]}  #collect db data to pass to Javascript chart
	end
end
