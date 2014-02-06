module SessionsHelper

	#####
	# Sign in user, create a cookie.
	#####
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	#####
	# return the present user as current user
	#####
	def current_user=(user)
		@current_user = user
	end

	######
	# estbalish current user according to remember_token(cookie)
	######
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	######
	# Check if the user is signed in
	######
	def signed_in? 
		!current_user.nil?
	end

	#####
	# Check if the user is the current_user
	#####
	def current_user?(user)
		user == current_user
	end

	#####
	# Sign out the user and remove the cookie.
	#####
	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))

		cookies.delete(:remember_token)
		self.current_user = nil
	end

	######
	# redirect back to the page the user was visiting before sign in request or to default (home)
	######
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	####
	# Check if user is signed in, if not direct to sign_in page and store location for redirect_back
	#####
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url 
			flash[:success] = "Please sign in."
		end
	end
	
	####
	# Store location for redirect back.
	#####
	def store_location
		session[:return_to] = request.url if request.get?
	end
end
