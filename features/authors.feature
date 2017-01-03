Feature: Authors
  As a user
  I want to browse the authors database
  So I can find their books

  Scenario: List authors
    Given an author with name "Brandon Sanderson"
    And a user requests "/authors"
    Then the status should be 200
    And the response should have a "self" link to "/authors"
    And the response has embedded "authors" with
      | name              |
      | Brandon Sanderson |
