class StaticPagesController < ApplicationController

	def home
		if signed_in?
			redirect_to '/workoutlog'
		end
	end

	def help
	end

	def about 
	end

end
