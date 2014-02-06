class Segment < ActiveRecord::Base
	belongs_to :exercise
	belongs_to :workout, primary_key: 'workout_id'
	validates :reps, :numericality => {:greater_than_or_equal_to => 0, message: "Please enter a positive number"} # make sure they enter a number bigger than 0
	validates :weight, :numericality => {:greater_than_or_equal_to => 0, :message => "Please enter a positive number"}

end
