Feature: Manage lunch
  In order to make a lunch
  As an admin
  I want to create and manage lunch

  Scenario: Create valid menu
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then I see a successful sign in message
    When I return to the site
    Then I should be signed in
    Given I have no restaurant
    And I go to the list of restaurants
    Then I should see "Restaurants"
    When I follow "New Restaurant"
    And I fill in "restaurant_name" with "Restaurant1"
    And I press "Create Restaurant"
    And I should see "Restaurant was successfully created."
    Given I have no menus
    And I go to the list of menus
    Then I should see "Menu"
    When I follow "New Menu"
    And I fill in "menu_title" with "Meniul1"
    And I select "1" from "menu[restaurant_id]"
    And I press "Create Menu"
    Then I should see "Menu was successfully created."
    And I should see "Meniul1"
    And I should see "2016-09-28"
    And I should see "1"
    And I should have 1 menu

  Scenario: Delete valid order
    Given I exist as a user
    And I am not logged in
    When I sign in with valid data
    Then I see a successful sign in message
    When I return to the site
    Then I should be signed in
    Then show me the page
    Given I have orders titled Pending
    When I go to the list of orders
    Then I follow "Destroy"
    And I should see "Order was successfully destroyed."
    And I should have 0 order
