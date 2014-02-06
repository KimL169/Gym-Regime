module ResultsPagesHelper

	#######
	# return strength of all exercises of a given name.
	#######
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

	#######
	# Method to return right date format for bodylog table.
	#######
	def format_date(my_date)
  		my_date.strftime('%m/%d/%Y')
	end

	######
	# check if target calories within range (allow leeway) and return boolean.
 	######
	def target_kcal(calories, targetkcal)
		if targetkcal == nil || calories == nil
			return nil
		elsif calories > (targetkcal+100) || calories < (targetkcal-100) #100 kcal leeway
			return false
		else
			return true
		end
	end

	#####
	# Remove duplicate exercise names from list (at strength chart)
	####
	def get_exercise_list(exercises)
		exerciseList = Array.new
		exercises.each do |e|
			unless exerciseList.include?(e.name) 
				exerciseList.append(e.name)
			end
		end
		return exerciseList
	end

	########
	# Check if the target weight is reached and allow for a little leeway (0.1 kg)
	######
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

	#######
	# return a string for integer rating in database.
	#######
	def display_workout_rating(rating)
		array = ["Excellent", "Good", "Okay", "Not so good", "Bad"]
		if rating == nil
			return nil
		else 
			return array[rating-1] 
		end
	end

	#######
	# Calculate target calories according to user prefered changerate.
	#######
	def get_target_calories(profile, weight)
		if profile.gender != nil && profile.height != nil && profile.age != nil && profile.activity != nil && weight != nil && profile.changerate != nil
			bmr_maintenance = harrisbenedict(profile.gender, profile.height, profile.age, weight, profile.activity)

			new_target_calories = (bmr_maintenance[:maintenance] + (1000 * profile.changerate)).round(0) # 1kg fat = 7000 kcal, 1 kg a week change = +-1000 a day.

			if new_target_calories != profile.caltarget
				profile.update_attributes(caltarget: new_target_calories)
			end
			return new_target_calories
		else
			return nil
		end
	end

end



