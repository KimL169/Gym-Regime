class Bodylog < ActiveRecord::Base
	belongs_to :user

	validate :user_quota, :on => :create
	validate :inputs

	def user_quota
		if user.bodylogs.today.count >= 1
			errors[:base] << "You have already added a log enty today.
							Please edit the existing entry"
		end
	end

	def inputs
		unless weight || kcal || bodyfat
			errors[:base] << "You must enter at least one body statistic"
		end
	end

	def maintenace
	end
end
