require 'spec_helper'

describe "Static pages" do

	describe "Home page" do

		it "should have the content 'Logbook' " do
			visit '/static_pages/home'
			expect(page).to have_content('Logbook')
		end
	end

	describe "Help page" do 

		it "should have content 'help'" do
			visit '/static_pages/help' 
			expect(page).to have_content('Help')
		end
	end

	describe "About page" do 

		it "should have content 'About' " do
			visit '/static_pages/about'
			expect(page).to have_content('About')
		end
	end
end
