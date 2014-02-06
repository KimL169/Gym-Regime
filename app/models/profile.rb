class Profile < ActiveRecord::Base
	belongs_to :user

	####
	# Validations not necessary because of already restricted form input.
	####
end
