module WorkoutsHelper


	def get_max(workout)
		workout.exercises.each do |e|
			arr = Array.new
			e.segments.each {|s| arr.append(one_rep_max(s.weight, s.reps))}
			max = arr.max
			e.update_column(:strength, max)
			e.save
		end
	end

	def one_rep_max(weight, reps)
		if reps > 10
			return 0 
		else
			return (weight/ (1.0279 - (0.0278 * reps)))
		end
	end
end
