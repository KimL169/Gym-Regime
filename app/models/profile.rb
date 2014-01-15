class Profile < ActiveRecord::Base
	belongs_to :user

	validates :age, length: {maximum: 3}
end
