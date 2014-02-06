class Exercise < ActiveRecord::Base
	belongs_to :workout
	belongs_to :user, primary_key: 'user_id'	
	has_many :segments, dependent: :destroy
	accepts_nested_attributes_for :segments, :allow_destroy => true, 
									reject_if: proc { |attributes| attributes['reps'].blank? }, #will not accept submission if reps are not filled in
									reject_if: proc { |attributes| attributes['weight'].blank? } #will not accept submission if weight are not filled in
	validates :name, presence: true
	before_save { self.name = name.downcase } #all to downcase for easier look up.

end
