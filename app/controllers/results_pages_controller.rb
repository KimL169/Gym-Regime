class ResultsPagesController < ApplicationController
	include ResultsPagesHelper
	include ApplicationHelper
	before_action :signed_in_user
	respond_to :html, :json

	def index
		#bodylogs
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at DESC', per_page: 7
		@bodylogs = @user.bodylogs.all
		@date = params[:month] ? Date.parse(params[:month]) : Date.today  # for the calendar date selector
		@profile = @user.profile
		gon.weight = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.weight]} #collect db data to pass to Javascript chart
		gon.kcal = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.kcal]} #collect db data to pass to Javascript chart
		@exercises = @user.exercises.all
		
		gon.days_ago = get_days_ago(@bodylogs)
		gon.created_at = []
		@bodylogs.each { |e| gon.created_at.append(e.created_at)}

		#workouts
		@workouts = @user.workouts.all
		@workoutsTable = @user.workouts.paginate page: params[:page], order: 'created_at DESC', per_page: 7
		@strengthList = get_strength(params[:exercise])
		gon.exercise_name = params[:exercise] #provide graph with the proper name
		gon.strength =  @strengthList.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.strength]}  #collect db data to pass to Javascript chart
	end
end
