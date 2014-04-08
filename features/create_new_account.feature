Feature: create a new account
 
  As a social being
  So that I can interact with my friends
  I want to create a new account on the best social network website ever

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | pope     | The        | Pope      | jesus    |

  And I am on the SocialNetwork home page

Scenario: correctly create account
  When I follow "Make new account"
  Then I should be on the new page
  When I fill in "Username" with "cvpoulton"
  When I fill in "First Name" with "Chris"
  When I fill in "Last Name" with "Poulton"
  When I fill in "Password" with "colorado"
  When I fill in "Confirm Password" with "colorado"
  When I press "Create Account"
  Then I should be on the newsfeed page
