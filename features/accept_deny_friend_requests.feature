Feature: requesting friends
 
  As a social being
  So that I can interact (or not) with my friends
  I want to be able to accept or deny friend requests

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | cpoulton | Chris      | Poulton   | whatup   |
  | kgavin   | Kris       | Gavin     | whadup   |

  Given the following pending friendships exist:
  | user_id | from_user |
  | 1       | 2         | 

  And I am logged in as "cpoulton" with password "whatup"
  And I am on the newsfeed page

Scenario: accept friend request
  When I follow "Profile Preferences"
  Then I should see "Kris Gavin"
  And I should see "Add"
  When I follow "Add"
  Then I should see "Kris added as friend"

Scenario: deny friend request
  When I follow "Profile Preferences"
  Then I should see "Kris Gavin"
  And I should see "Deny"
  When I follow "Deny"
  Then I should see "Friend request from Kris denied"
