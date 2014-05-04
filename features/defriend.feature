Feature: defriending friends
 
  As a social being
  So that I can not have to talk to my "friend"
  I want to be able to defriend my "friend"

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

Scenario: defriending friend
  When I follow "Profile Preferences"
  Then I should see "Kris Gavin"
  And I should see "Defriend"
  When I follow "Defriend"
  Then I should see "Defriended Kris"
