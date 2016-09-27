Feature: Manage menus
  In order to make a menu
  As an admin
  I want to create and manage menus

  Scenario: Create valid menu
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then show me the page
    And I see a successful sign in message
    When I return to the site
    Then I should be signed in
    Given I have no menus
    And I go to the list of menus
    Then I should see "Menu"
    When I follow "New Menu"
    And I fill in "menu_title" with "Meniul1"
    And I press "Create Menu"
    Then I should see "Menu was successfully created."
    And I should see "Meniul1"
    And I should see "2016-09-27"
    And I should see "1"
    And I should have 1 article
