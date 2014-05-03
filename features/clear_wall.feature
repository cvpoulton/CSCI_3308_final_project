Feature: clearing wall
 
  As a social being
  So that I can erase my history
  I want to be able to clear my wall

Background: 
  Given the following users exist:
  | username | first_name | last_name | password |
  | cpoulton | Chris      | Poulton   | whatup   |

  And I am logged in as "cpoulton" with password "whatup"
  And I am on the newsfeed page

Scenario: clear wall
  When I follow "Profile Page"
  And I fill in "Message" with "I'm the best"
  And I press "Post status"
  Then I should see "Status of Chris Poulton"
  And I should see "I'm the best"

  When I follow "Profile Preferences"
  And I follow "Clear Wall"
  And I follow "Profile Page"
  Then I should not see "Status of Chris Poulton"
