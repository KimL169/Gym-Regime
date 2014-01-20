class Exercise < ActiveRecord::Base
	belongs_to :workout
	has_many :segments, dependent: :destroy
	accepts_nested_attributes_for :segments, :allow_destroy => true, :reject_if => proc { |a| a[:weight].blank? && a[:reps].blank? }

	validates :name, presence: true

	
end
