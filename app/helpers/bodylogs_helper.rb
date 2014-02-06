module BodylogsHelper
	########
	# Calorie calculator.
	#######
	def harrisbenedict(gender, height, age, weight, activity)

		if gender == 1 #male
			brm = 66.4730 + (13.7516 * weight) + (5.0033 * height) - (6.7550 * age)
		elsif gender == 2 #female
			brm =  447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
		else 
			return
		end
		if activity == 1 #calory mutlipliers for user activity level.
			multiplier = 1.2
		elsif activity == 2
			multiplier = 1.375
		elsif activity == 3
			multiplier = 1.55
		elsif activity == 4
			multiplier = 1.725
		elsif activity == 5
			multiplier = 1.9
		end
		maintenance = brm * multiplier 
		return maintenance
	end

	#########
	# Method to check right amount of logs to establish changerate.
	#########
	def get_days_ago(logs)
		if logs.any? && logs.count > 6
			lastlog = logs.first
			first_entry = lastlog.created_at.to_date
			now = Date.today
			days_past =  (now - first_entry)
			return days_past.days.ago.at_midnight.to_i * 1000 
		else
			return 1.weeks.ago.at_midnight.to_i * 1000
		end
	end


end

