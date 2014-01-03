require 'spec_helper'
include ApplicationHelper

describe "Static pages" do

	describe "Home page" do

		it "should have the content 'Logbook' " do
			visit root_path
			expect(page).to have_content('Logbook')
		end
	end

	describe "Help page" do 

		it "should have content 'help'" do
			visit help_path 
			expect(page).to have_content('Help')
		end
	end

	describe "About page" do 

		it "should have content 'About' " do
			visit about_path
			expect(page).to have_content('About')
		end
	end

	it "should have right links on the layout" do
		visit root_path
		click_link "About"
		expect(page).to have_title(full_title('About'))
		click_link "Help"
		expect(page).to have_title(full_title('Help'))
		click_link "Contact"
		expect(page).to have_title(full_title('Contact'))
		click_link "Logbook"
		click_link "Sign up now!"
		expect(page).to have_title(full_title('Sign up'))
		click_link "WorkoutBook"
		expect(page).to have_title(full_title(''))
	end
end
