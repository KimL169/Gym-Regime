class Bodylog < ActiveRecord::Base
	belongs_to :user
	
	validate :inputs
	validates_uniqueness_of :user_id, :scope => [:user_id, :created_at]


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

	def inputs
		unless weight || kcal || bodyfat
			errors[:base] << "You must enter at least one body statistic."
		end
	end

end
