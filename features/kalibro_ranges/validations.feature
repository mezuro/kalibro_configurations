Feature: Kalibro Ranger Validators
  In order to have valid Ranges for a Metric Configuration
  As a regular user
  I should only be able to create Ranges with correct attributes

  Scenario: With an existing overlapping Range
    Given Pending: Overlapping validation is broken
    Given I have a Metric Configuration
    And I have a Reading
    And I have a Range from "-43" to "43"
    When I create a Range from "-42" to "42"
    Then I should get a validation error for "beginning"
    And the Range should not have been saved
