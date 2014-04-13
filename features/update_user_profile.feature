Feature: update user profile

  As a social being
  So that my friends know me
  I want to be able to update my user profile

Background:
  Given the following users exist:
  | username  | first_name | last_name | password | interests          | quotes     |
  | cvpoulton | Chris      | Poulton   | nailedit | Food and CSCI 3308 | Nailed it! |

  And I am logged in as "cvpoulton" with password "nailedit"
  And I am on the newsfeed page

Scenario: update user profile
  Then my interests should be "Food and CSCI 3308"
  And my quotes should be "Nailed it!"
  When I follow "Profile Preferences"
  Then I should be on the preferences page
  When I fill in "Interests" with "Pizza and computer science"
  When I fill in "Quotes" with "Killing it!"
  When I press "Update"
  Then I should be on the preferences page
  And I should see "Updated profile!"
  And my interests should be "Pizza and computer science"
  And my quotes should be "Killing it!"
