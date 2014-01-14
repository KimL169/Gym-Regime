require 'spec_helper'
include ApplicationHelper

describe "Logbook pages" do

	describe "workoutlog" do
		before {visit '/workoutlog'}

		it {should have_title(full_title('Workout Logbook'))}
		it {should have_content(full_title('Workout Logbook'))}
	end

	describe "bodylog" do 
		before { visit '/bodylog'}

		it {should have_title(full_title('Body Log'))}
		it {should have_content('Body Log')}
	end

end