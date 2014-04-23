require 'spec_helper'


describe "Webpage" do
	
	before(:each) do
			User.create(:username => 'yo', :password => 'man')
			user_login('yo', 'man')
			#user_login('chris', 'chris')
	end

	describe "Newsfeed Title" do

		it "should have the content 'Newsfeed Title'" do
			visit newsfeed_path
			expect(page).to have_title('Newsfeed')
		end
	end

	describe "Preferences Title" do
		it "should have the content 'Profile Preferences Title'" do
			visit preferences_path
			expect(page).to have_title('Profile Preferences')
		end
	end

	describe "Search/Add Users Title" do
		it "should have the content 'Search/Add Users Title'" do
			visit friends_path
			expect(page).to have_title('Search/Add Users')
		end
	end
end



