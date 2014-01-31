class Bodylog < ActiveRecord::Base
	belongs_to :user
	
	validate :user_quota, :on => :create
	validate :inputs

	before_save :round_input

	def round_input
		if self.weight != nil
			self.weight.round
		end
		if self.kcal != nil
			self.kcal.round 
		end
		if self.bodyfat != nil
			self.bodyfat.round
		end
	end

	def user_quota
		if user.bodylogs.today.count >= 1
			errors[:base] << "You have already added a log enty today.
							Please edit the existing entry"
		end
	end

	def inputs
		unless weight || kcal || bodyfat
			errors[:base] << "You must enter at least one body statistic."
		end
	end

end
