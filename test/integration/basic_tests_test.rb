require 'test_helper'

#class BasicTestsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
#end


describe "Newsfeed" do

	it "should have the content 'Newsfeed'" do
		visit '/newsfeed'
		expect(page).to have_content('Sample App')

	end
end