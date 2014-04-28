Feature: create a new account
 
  As a social being
  So that I can interact with my friends
  I want to create a new account on the best social network website ever

Background:
  Given the following users exist:
  | username | first_name | last_name | password | password_confirmation |
  | pope     | The        | Pope      | jesus    | jesus                 |

  And I am on the SocialNetwork home page

Scenario: correctly create account
  When I follow "Make new account"
  Then I should be on the new page
  When I fill in "Username" with "cvpoulton"
  When I fill in "First name" with "Chris"
  When I fill in "Last name" with "Poulton"
  When I fill in "Password" with "colorado"
  When I fill in "Confirm password" with "colorado"
  When I press "Create Account"
  Then I should be on the newsfeed page

Scenario: passwords don't match
  When I follow "Make new account"
  Then I should be on the new page
  When I fill in "Username" with "cvpooltron"
  When I fill in "First name" with "Chris"
  When I fill in "Last name" with "Poulton"
  When I fill in "Password" with "denver"
  When I fill in "Confirm password" with "boulder"
  When I press "Create Account"
  # Should be redirected to new page instead of newsfeed
  Then I should be on the new page
  # Should say the passwords don't match
  And I should see "doesn't match" 

Scenario: forgot name information
  When I follow "Make new account"
  Then I should be on the new page
  When I fill in "Username" with "cvpoultry"
  When I fill in "Password" with "railsrules"
  When I fill in "Confirm password" with "railsrules"
  When I press "Create Account"
  # Should be redirected to new page instead of newsfeed
  Then I should be on the new page
  And I should see "can't be blank"

Scenario: user already exists
  When I follow "Make new account"
  Then I should be on the new page
  When I fill in "Username" with "pope"
  When I fill in "First name" with "Da"
  When I fill in "Last name" with "Popey"
  When I fill in "Password" with "mary"
  When I fill in "Confirm password" with "mary"
  When I press "Create Account"
  # Should be redirected to new page instead of newsfeed
  Then I should be on the new page
  # Should say the username is already taken
  And I should see "already taken"
