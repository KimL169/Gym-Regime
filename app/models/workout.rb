class Workout < ActiveRecord::Base
	belongs_to :user
	has_many :exercises, dependent: :destroy
	accepts_nested_attributes_for :exercises, :allow_destroy => true, :reject_if => proc { |a| a[:name].blank? }

	validates :name, presence: true
end
