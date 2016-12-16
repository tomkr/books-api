Feature: Books

  Scenario: List books
    Given a couple of books
    And a user requests a list of books
    Then the response should contain "title"
