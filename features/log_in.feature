Feature: logging in
 
  As a social being
  So that I can interact with my friends
  I want to create a new account on the best social network website ever

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | man     | The        | Pope      | rothchild   |

  And I am on the SocialNetwork home page

Scenario: correcty log in
  When I fill in "Username" with "man"
  When I fill in "Password" with "rothchild"
  When I press "Login"
  Then I should be on the newsfeed page


  Scenario: bad password
   When I fill in "Username" with "man"
   When I fill in "Password" with "roth"
   When I press "Login"
   Then I should see "Wrong password!"

  Scenario: username doesn't exist
   When I fill in "Username" with "hershel"
   When I fill in "Password" with "roth"
   When I press "Login"
   Then I should see "Username not found!"