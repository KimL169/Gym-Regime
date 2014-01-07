require 'spec/spec_helper'
include ApplicationHelper

describe "ContactForm" do 
	it "delivers a valid message" do
		visit new_contact_form_path
		fill_in 'Name', :with => 'Bobby Love'
		fill_in 'Email', :with => 'krelandeweer@gmail.com'
		fill_in 'Message', :with => 'What a great website.'
		click_button 'Send message'
		page.body.should have_content('Thank you for your message')
	end

	it "does not deliver a message with a missing email" do
		visit new_contact_form_path
		fill_in 'Name', :with => 'Bobby Love'
		fill_in 'Message', :with => 'blahblah'
		click_button 'Send message'
		page.body.should have_content("Email can't be blank")
	end

	it "should have title 'Contact'" do
		visit 'new_contact_form_path'
		expect('page').to have_title('WorkoutBook | Contact')
	end
end