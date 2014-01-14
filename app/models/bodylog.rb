class Bodylog < ActiveRecord::Base
	belongs_to :user

	def today
		where(:created_at => (Time.now.beginning_of_day..Time.now))
	end
end
