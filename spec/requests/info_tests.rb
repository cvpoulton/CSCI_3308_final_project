require 'spec_helper'

describe "Profile Info" do

	before(:each) do
		User.create!(:username => 'JonnyBoi', :password => 'passwerd', :first_name => 'Jonny', :last_name => 'Boi', :interests => "RoR", :quotes => "Lud me some Rub")
	end
	
	describe "Profile Information on Profile Page" do
		it "should appear on Profile Page" do
			user_login('JonnyBoi', 'passwerd')
			click_link('Profile Page')
			expect(page).to have_content('RoR')
			expect(page).to have_content('Lud me some Rub')
		end
	end

	describe "Changing Profile Information" do
		it "should appear on Profile Page after updating" do
			user_login('JonnyBoi', 'passwerd')
			visit preferences_path
			fill_in("Quotes", :with => "Almost done!")
  			fill_in("Interests", :with => "WoW")
			click_button('Update Profile')
			click_link('Profile Page')
			expect(page).to have_content('Almost done!')
			expect(page).to have_content('WoW')
		end
	end
			
end