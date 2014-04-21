Feature: logging in
 
  As a social being
  So that I can interact with my friends
  I want to log into my account on the best social network website ever

Background: 
  Given the following users exist:
  | username | first_name | last_name | password  |
  | man      | The        | Man       | rothchild |

  And I am on the SocialNetwork home page

Scenario: correcty log in
  When I fill in "Username" with "man"
  When I fill in "Password" with "rothchild"
  When I press "Login"
  Then I should be on the newsfeed page
  And I should see "The Man is logged in"

Scenario: bad password
  When I fill in "Username" with "man"
  When I fill in "Password" with "roth"
  When I press "Login"
  Then I should be on the login page
  And I should see "Wrong password!"

Scenario: username doesn't exist
  When I fill in "Username" with "hershel"
  When I fill in "Password" with "roth"
  When I press "Login"
  Then I should be on the login page
  And I should see "Username not found!"

Scenario: redirecting if not logged in
  When I am on the newsfeed page
  Then I should be on the login page
  When I am on the profile page
  Then I should be on the login page
  When I am on the preferences page
  Then I should be on the login page
  When I am on the friends page
  Then I should be on the login page

Scenario: not redirecting if logged in
  When I fill in "Username" with "man"
  When I fill in "Password" with "rothchild"
  When I press "Login"
  When I am on the newsfeed page
  Then I should be on the newsfeed page
  When I am on the preferences page
  Then I should be on the preferences page
  When I am on the friends page
  Then I should be on the friends page
