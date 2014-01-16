module ProfileHelper

	def harrisbenedict(gender, height, age, weight, activity)
		if gender == 1
			brm = 66.4730 + (13.7516 * weight) + (5.0033 * height) - (6.7550 * age)
		elsif gender == 2
			brm =  447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
		else 
			return
		end

		if activity == 1
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


	def changerate
		user = current_user
		bodylogs = user.bodylogs.last(7)
		if bodylogs.count < 7
			return "Not enough log entries to calculate"
		end
		profile =  user.profile
		lastlog = bodylogs.last
		d = DateTime.now
		days_diff = (lastlog.created_at - d).to_i

		if days_diff > 8
			return "This function is only availible with
			 		consistent daily logging of results"
		else
			ar = Array.new
			bodylogs.each do |b|
				m = harrisbenedict(profile.gender, profile.height, profile.age, b.weight, profile.activity)
				ar.push(b.kcal - m)
			end
			sum = ar.sum
			change = (sum / 7000)
			return change
		end
	end
end