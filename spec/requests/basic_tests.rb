require 'spec_helper'

#class BasicTestsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
#end
=begin
describe "Login" do
	before(:all) do
	User.create(:username => 'yo', :password => 'man')
	user_login('yo', 'man')
	user_login('chris', 'chris')
end
=end
describe "Webpage" do
	
	before(:each) do
			User.create(:username => 'yo', :password => 'man')
			user_login('yo', 'man')
			#user_login('chris', 'chris')
	end

	describe "Newsfeed" do

		
		it "should have the content 'Newsfeed'" do
			visit newsfeed_path
			expect(page).to have_content('Newsfeed')
		end
	end


	describe "Preferences" do
		it "should have the content 'Preferences'" do
			visit preferences_path
			expect(page).to have_content('Preferences')
		end
	end

	describe "Search/Add Users" do
		it "should have the content 'Search/Add Users'" do
			visit preferences_path
			expect(page).to have_content('Search/Add Users')
		end
	end
end



