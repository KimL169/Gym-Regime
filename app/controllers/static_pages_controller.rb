class StaticPagesController < ApplicationController
	######
	# Home page = sign-up page, if signed-in redirect
	######
	def home
		if signed_in?
			redirect_to '/results'
		end
	end

	######
	# Help page. Contains FAQ
	#####
	def help
	end

	#######
	# About page. 
	######
	def about 
	end

end
