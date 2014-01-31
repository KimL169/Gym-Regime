class Exercise < ActiveRecord::Base
	belongs_to :workout
	belongs_to :user, primary_key: 'user_id'
	has_many :segments, dependent: :destroy
	accepts_nested_attributes_for :segments, :allow_destroy => true, reject_if: proc { |attributes| attributes['reps'].blank? },
																		reject_if: proc { |attributes| attributes['weight'].blank? }
	validates :name, presence: true
	before_save { self.name = name.downcase }

end
