Feature: posting on walls
 
  As a social being
  So that I can talk to my friends
  I want to be able to post on their walls

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | cpoulton | Chris      | Poulton   | whatup   |
  | kgavin   | Kris       | Gavin     | whadup   |

  Given the following friendships exist:
  | user_id | other_user |
  | 1       | 2          | 
  | 2       | 1          | 

  And I am logged in as "cpoulton" with password "whatup"
  And I am on the newsfeed page

Scenario: post on friend's wall
  When I follow "Profile Preferences"
  And I follow "Kris Gavin"
  And I fill in "Message" with "I love you dude"
  And I press "Post to wall"
  Then I should see "Chris Poulton to Kris Gavin"
  And I should see "I love you dude"

Scenario: update status
  When I follow "Profile Page"
  And I fill in "Message" with "I'm the best"
  And I press "Post status"
  Then I should see "Status of Chris Poulton"
  And I should see "I'm the best"
