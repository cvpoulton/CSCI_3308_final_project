Feature: posting on walls
 
  As a social being
  So that I can see what my friends are up to
  I want to be able to view my newsfeed

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | cpoulton | Chris      | Poulton   | whatup   |
  | kgavin   | Kris       | Gavin     | whadup   |

  Given the following friendships exist:
  | user_id | other_user |
  | 1       | 2          | 
  | 2       | 1          | 

  Given the following posts exist:
  | user_id | from_user | message  |
  | 1       | 2         | Hey dude |

  And I am logged in as "cpoulton" with password "whatup"
  And I am on the newsfeed page

Scenario: see existing messages on the newsfeed
  I should see "Kris Gavin to Chris Poulton"
  I should see "Hey dude"

Scenario: see new messages on the newsfeed
  When I follow "Profile Page"
  And I fill in "Message" with "I'm the best"
  And I press "Post status"
  Then I should be on the profile page
  And I follow "Newsfeed"
  Then I should see "Status of Chris Poulton"
  And I should see "I'm the best"

Scenario: update status from the newsfeed
  When I fill in "Status" with "I'm the best"
  And I press "Post status"
  Then I should be on the newsfeed page
  And I should see "Status of Chris Poulton"
  And I should see "I'm the best"
