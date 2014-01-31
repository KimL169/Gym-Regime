class ResultsPagesController < ApplicationController
	include ResultsPagesHelper
	before_action :signed_in_user
	respond_to :html, :json

	def index

		#bodylogs
		@user = current_user
		@bodylogsTable = @user.bodylogs.paginate page: params[:page], order: 'created_at DESC', per_page: 5
		@bodylogs = @user.bodylogs.all
		@date = params[:month] ? Date.parse(params[:month]) : Date.today  # for the calendar date selector
		@profile = @user.profile
		gon.weight = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.weight]}
		gon.kcal = @bodylogs.map{ |row| [row.created_at.beginning_of_day.to_i * 1000, row.kcal]}
		@exercises = @user.exercises.all
		
		gon.days_ago = get_days_ago(@bodylogs)
		gon.created_at = []
		@bodylogs.each { |e| gon.created_at.append(e.created_at)}

		#workouts
		@workouts = @user.workouts.all
		@workoutsTable = @user.workouts.paginate page: params[:page], order: 'created_at DESC', per_page: 7
		@selected_exercise = params[:exercise]
		gon.strength = get_strength(@selected_exercise)
		#exercise selector for chart
	end
end
