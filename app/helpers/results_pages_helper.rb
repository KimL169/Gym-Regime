module ResultsPagesHelper


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
		return {brm: brm, maintenance: maintenance}
	end

	def get_strength(exercise)
		strengthlist = Array.new
		exercises = current_user.exercises.where('name =  :name', {:name => exercise})
		exercises.each do |ex|
			if ex.strength != nil
				strengthlist.append(ex)
			end
		end
		return strengthlist
	end

	def format_date(my_date)
  		my_date.strftime('%m/%d/%Y')
	end

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

	def target_kcal(calories, targetkcal)
		if targetkcal == nil || calories == nil
			return nil
		elsif calories > (targetkcal+100) || calories < (targetkcal-100) #100 kcal leeway
			return false
		else
			return true
		end
	end

	def get_rating(rating)
		array = ["excellent", "good", "okay", "not so good", "bad"]
		return array[rating-1]
	end

	#remove duplicate exercise names from list.
	def get_exercise_list(exercises)
		exerciseList = Array.new
		exercises.each do |e|
			unless exerciseList.include? e.name
				exerciseList.append(e.name)
			end
		end
		return exerciseList
	end


	def target_weight_reached(weight)
		weighttarget = current_user.profile.weighttarget 
		if weighttarget != nil
			if weight < (weighttarget - 0.10) || weight > (weighttarget + 0.10) # 0.10kg leeway.
				return false
			else
				return true
			end
		else
			return false
		end
	end

	def display_workout_rating(rating)
		array = ["Excellent", "Good", "Okay", "Not so good", "Bad"]
		if rating == nil
			return nil
		else 
			return array[rating-1]
		end
	end


	def get_target_calories(profile, weight)
		if profile.gender != nil && profile.height != nil && profile.age != nil && profile.activity != nil && weight != nil && profile.changerate != nil
			bmr_maintenance = harrisbenedict(profile.gender, profile.height, profile.age, weight, profile.activity)
			maintenance = bmr_maintenance[:maintenance]
			return (maintenance + (1000 * profile.changerate)).round(0)
		else
			return nil
		end
	end

end



