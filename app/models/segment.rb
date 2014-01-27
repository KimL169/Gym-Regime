class Segment < ActiveRecord::Base
	belongs_to :exercise
	has_one :workout, through: :exercise
	validates :reps, :numericality => {:greater_than_or_equal_to => 0, message: "Please enter a positive number"}
	validates :weight, :numericality => {:greater_than_or_equal_to => 0, :message => "Please enter a positive number"}

end
