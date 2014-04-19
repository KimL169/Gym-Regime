class Workout < ActiveRecord::Base
	belongs_to :user
	has_many :exercises, dependent: :destroy
	has_many :segments, dependent: :destroy
	has_many :cardios, dependent: :destroy

	accepts_nested_attributes_for :exercises, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? } #reject if no name is given
 	accepts_nested_attributes_for :cardios, :allow_destroy => true, reject_if: proc { |attributes| attributes['name'].blank? } #reject if no name is given

	before_save { self.name = name.downcase } #to downcase for easier look up.
	
end
