Feature: send friend request
 
  As a social being
  So that I can interact with my friends
  I want to be able to send friend requests

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | cpoulton | Chris      | Poulton   | whatup   |
  | kgavin   | Kris       | Gavin     | whadup   |
  | jgantin  | Jay        | Pii       | whaup    |

  And I am logged in as "cpoulton" with password "whatup"
  And I am on the newsfeed page

Scenario: send a friend request
  When I follow "Search/Add Users"
  And I fill in "Last Name" with "Gavin"
  And I press "Search"
  And I follow "Kris Gavin"
  And I follow "Send friend request"
  Then I should see "Friend Request Sent!"

