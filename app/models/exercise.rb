class Exercise < ActiveRecord::Base
	belongs_to :workout
	has_many :segments

	validates :name, presence: true
end
