module ProfileHelper

	#######
	# Calorie calculator
	#######
	def harrisbenedict(gender, height, age, weight, activity)
		calibration = current_user.settings(:kcal_calculator).calibration
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
		maintenance = (brm * multiplier + calibration)
		return {brm: brm, maintenance: maintenance} #return array. [:bmr] = bmr, [:maintenance] = maintenance
	end

	def katchmcardle(height, age, weight, bodyfat, activity)
       # TODO
	end

	########
	# Rate of estimated weight loss established based on caloric intake over 7 day period.
	########
	def changerate
		user = current_user
		bodylogs = user.bodylogs.where(:created_at => 1.week.ago..Date.tomorrow) #one week of kcal records
		if bodylogs.count('kcal') != 7 # make sure there are 7 kcal entries for this week.
			return "Not enough consistent log entries to calculate"
		else
			profile = user.profile
			ar = Array.new
			bodylogs.each do |b|
				m = harrisbenedict(profile.gender, profile.height, profile.age, b.weight, profile.activity)
				ar.push(b.kcal - m[:maintenance]) #m[:maintenance] = maintenance calories.
			end
			sum = ar.sum
			change = (sum / 7000) #7000 kcal = 1kg of fat
			return change
		end
	end

	########
	# Get time estimate in weeks until target weight is achieved (based on changerate method.)
	#######
	def time_estimate(profile)
		user = current_user
		if profile.weighttarget == nil || changerate == nil
			return "You need a target weight and at least 7 consistent log entries."
		end
		lastlog = user.bodylogs.last
		if lastlog.weight
			current_weight = lastlog.weight
			diff = current_weight - profile.weighttarget

			rate = actualChangeRate()
			if rate.to_f != 0
				if rate > 0 && diff > 0
					return "You've been moving away from your target weight goal for the past week"
				elsif rate < 0 && diff < 0
					return "You've been moving away from your target weight goal for the past week"
				else
					return ((diff / rate).abs).round(1)
				end
			else
				return "-"
			end
		else
			return "No current weight logged"
		end
	end

	#######
	#Search latest bodyfat record to display in profile.
	#######
	def get_fat(bodylogs)
		bodylogs.each do |log|
			if log.bodyfat != nil
				if log.bodyfat > 0
					return log.bodyfat
				end
			end
			return 'No (recent) bodyfat record'
		end
	end

	#####
	#Check if return funtion is a number (string in case of a message )
	#####
	def is_number(input)
 		input.to_f == input
	end

	def actualChangeRate
		user = current_user
		t = Time.now
		weekOldBodylog = user.bodylogs.where(:created_at => 1.week.ago.beginning_of_day..1.week.ago.end_of_day)
		todayBodylog = user.bodylogs.where(:created_at => t.beginning_of_day..t.end_of_day)
		if weekOldBodylog  == nil
			return "You need consistent log entries for this function"
		elsif todayBodylog == nil
			return "Please fill in your weight for today"
		end
		weekAgo = weekOldBodylog[0]
		today = todayBodylog[0]
		if weekAgo != nil && today != nil
			return (today.weight - weekAgo.weight).round(2)
		else
			return nil
		end
	end

	def discrepancy
		actual_change = actualChangeRate
		estimated_change = changerate

		if actual_change && estimated_change
			weight = estimated_change - actual_change
			return weight * 1000 #convert to calories.
		else
			return "not available"
		end
	end

end


