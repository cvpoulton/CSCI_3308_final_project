require 'spec_helper'

describe "Webpage" do

	before(:each) do
			user = FactoryGirl.create(:user)
			user_login(user.username, user.password)
	end

	
	describe "Newsfeed" do

		it "should have the content 'Newsfeed Page'" do
			visit newsfeed_path
			expect(page).to have_content('Newsfeed Page')
		end
	end
	
	describe "Login" do

		it "should have the content 'Login Page'" do
			visit login_path
			expect(page).to have_content('Login Page')
		end
	end

	describe "Preferences" do
		it "should have the content 'Preferences Page'" do
			visit preferences_path
			expect(page).to have_content('Preferences Page')
		end
	end

	describe "Search/Add Users" do
		it "should have the content 'Search/Add Users Page'" do
			visit friends_path
			expect(page).to have_content('Search/Add Users Page')
		end
	end

	describe "Profile Page" do

		it "should have the content 'Profile Page'" do
			visit profile_path(:userProfile => 1)
			expect(page).to have_content('Profile Page')
		end
	end

	describe "Create New Account" do

		it "should have the content 'Create New Account Page'" do
			visit new_path
			expect(page).to have_content('Create New Account Page')
		end
	end

end



