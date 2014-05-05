require 'spec_helper'

describe "Profile Info" do

	before(:each) do
		@user = FactoryGirl.create(:user, username: 'JonnyBoi', password: 'passwerd', password_confirmation: 'passwerd', first_name: 'Jonny', last_name: 'Boi', interests: "RoR", quotes: "Lud me some Rub", walldate: Time.now)
	end
	
	describe "Profile Information on Profile Page" do
		it "should appear on Profile Page" do
			user_login("#{@user.username}","#{@user.password}")
			click_link('Profile Page')
			expect(page).to have_content("#{@user.quotes}")
			expect(page).to have_content("#{@user.interests}")
		end
	end

	describe "Changing Profile Information" do
		it "should appear on Profile Page after updating" do
			user_login("#{@user.username}","#{@user.password}")
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
