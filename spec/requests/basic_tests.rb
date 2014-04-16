require 'spec_helper'

#class BasicTestsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
#end


describe "Newsfeed" do

	it "should have the content 'Newsfeed'" do
		visit '/newsfeed'
		expect(page).to have_content('Newsfeed')

	end
end