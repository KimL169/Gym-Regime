module WorkoutsHelper

	####
	# call one_rep_max calculator and update the segment.
	####
	def get_max(workout)
		workout.segments.each do |s|
			s.update_column(:strength, one_rep_max(s.weight, s.reps))
			s.save
		end
	end

	######
	# One rep max calculator according to Brzycki formula
	######
	def one_rep_max(weight, reps)
		if reps > 10 # reps need to be below 11 for accurate result.
			return nil 
		else
			return (weight/ (1.0279 - (0.0278 * reps)))
		end
	end

	#####
	# check if a new pr was reached on a segment for an exercise. If so, save it to the exercise and segment.
	# Save it to both for quicker look ups of exercise strength and showing of the specific segment on which
	# that strength was reached, along with possible future calculations requiring per segment strength.
	#####
	def check_pr(segment, exercise)
		#return true if this segment was a previous max (so that it will stay marked red).
		if segment.pr == 1 
			return true
		end
		#else find all the exercises by the same name and get the maximum strength
		exercises = current_user.exercises.where(name:"#{exercise.name}")
		exerciseList = []
		exercises.each do |ex|
			if ex.strength != nil
				exerciseList.append(ex.strength)
			end
		end
		previousPR = exerciseList.max 

		if segment.strength != nil
			if previousPR == nil || previousPR < segment.strength # check if new record has beaten the old one.
				exercise.update_column(:strength, segment.strength) #update the exercise with the record strength
				segment.update_column(:pr, 1) #mark the segment as a personal record segment.
				return true
			end
		end
	end

end
