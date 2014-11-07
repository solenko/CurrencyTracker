Feature: Manage countries
  In order to manage his travel itinerary
  Mr. Smart
  wants to manage the countries he has visited.

  Background:
    Given I logged in with "mrsmart@email.com"
  Scenario: List Countries
    Given the following countries exist:
      |name|code|
      |CountryOne|c1|
      |CountryTwo|c2|
      |CountryThree|c3|
      |CountryFour|c4|
      |CountryFive|c5|
    And user "mrsmart@email.com" visit countries "c3,c4,c5"
    And I am on the countries page
    Then I should see the following table:
      |Name|Code|Status|
      |CountryOne|c1|Not Visited|
      |CountryTwo|c2|Not Visited|
      |CountryThree|c3|Visited|
      |CountryFour|c4|Visited|
      |CountryFive|c5|Visited|

  Scenario: Visit Country
    Given I am on a country page
    And I follow "Mark Visited"
    Then I should see "Status: Visited"
