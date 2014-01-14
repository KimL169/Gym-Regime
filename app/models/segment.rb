class Segment < ActiveRecord::Base
	belongs_to :exercise
	has_one :workout, through: :exercise

	validates :weight, presence: true
	validates :reps, presence: true
end
