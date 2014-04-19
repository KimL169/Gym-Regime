class User < ActiveRecord::Base
	has_many :workouts, dependent: :destroy
	has_many :exercises
	has_many :cardios
	has_one :profile, dependent: :destroy
	has_many :bodylogs, dependent: :destroy do
		
		def today
			where(:created_at => (Time.now.beginning_of_day..Time.now))
		end
	end

	# user dashboard settings
	has_settings do |s|
		s.key :kcal_calculator, defaults: {type: 'Harris Benedict', calibration: 0, custom_workout: nil, custom_rest: nil}
		s.key :strength_calculator, defaults: {type: 'default'}
	end

	accepts_nested_attributes_for :profile


	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: {maximum: 30}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
									uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: {minimum:6}

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end

