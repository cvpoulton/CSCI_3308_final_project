Feature: search for last name

  As a social being
  So that I can find my friends
  I want to be able to search for users by last name

Background:
  Given the following users exist:
  | username  | first_name | last_name | password  | password_confirmation | interests          | quotes      |
  | cvpoulton | Chris      | Poulton   | nailedit  | nailedit              | Food and CSCI 3308 | Nailed it!  |
  | jp        | Jean       | Paul      | killingit | killingit             | Being really cool  | Killing it! |


  And I am logged in as "cvpoulton" with password "nailedit"
  And I am on the newsfeed page

Scenario: search by last name - users found
  When I follow "Search/Add Users"
  Then I should be on the friends page
  When I fill in "Last Name" with "Paul"
  And I press "Search"
  Then I should see "Jean Paul"

Scenario: search by last name - no users found
  When I follow "Search/Add Users"
  Then I should be on the friends page
  When I fill in "Last Name" with "Gavin"
  And I press "Search"
  Then I should see "No users found"
