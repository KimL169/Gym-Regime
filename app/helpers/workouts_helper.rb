module WorkoutsHelper


	def get_max(workout)
		workout.segments.each do |s|
			s.update_column(:strength, one_rep_max(s.weight, s.reps))
			s.save
		end
	end


	def one_rep_max(weight, reps)
		if reps > 10
			return nil 
		else
			return (weight/ (1.0279 - (0.0278 * reps)))
		end
	end

	def check_pr(segment, exercise)
		#return true if this segment was a previous max (so that it will be marked red).
		if segment.pr == 1
			return true
		end
		#else find all the exercises by the same name and get the maximum
		exercises = current_user.exercises.where(name:"#{exercise.name}")
		exerciseList = []
		exercises.each do |ex|
			if ex.strength != nil
				exerciseList.append(ex.strength)
			end
		end
		previousPR = exerciseList.max 

		if segment.strength != nil
			if previousPR == nil || previousPR < segment.strength
				exercise.update_column(:strength, segment.strength)
				segment.update_column(:pr, 1)
				return true
			end
		end
	end

end
