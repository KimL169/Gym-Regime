class Segment < ActiveRecord::Base
	belongs_to :exercise
	has_one :workout, through: :exercise

	validates :weight, presence: true, :numericality => {:greater_than_or_equal_to => 0}
	validates :reps, presence: true, :numericality => {:greater_than_or_equal_to => 0}

end
