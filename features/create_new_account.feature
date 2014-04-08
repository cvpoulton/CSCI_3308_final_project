Feature: create a new account
 
  As a social being
  So that I can interact with my friends
  I want to create a new account on the best social network website ever

Background: I am on the SocialNetwork home page

Scenario: correctly create account
  When I press "Make new account"
  Then I should be on the "Create New Account" page
  When I fill "Username" with "cvpoulton"
  When I fill "First Name" with "Chris"
  When I fill "Last Name" with "Poulton"
  When I fill "Password" with "colorado"
  When I fill "Confirm Password" with "colorado"
  And I press "Create Account"
  Then I should be on the "Newsfeed" page
