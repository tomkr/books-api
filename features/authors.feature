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
    And the first of "authors" has a "self" link to "/authors/brandon-sanderson"

  Scenario: Add an author
    Given a user posts '{"name": "George R. R. Martin"}' to "/authors"
    Then the status should be 201
    And the response should have "name" "George R. R. Martin"
    And the response should have a "self" link to "/authors/george-r-r-martin"

  Scenario: Add a malformed author
    Given a user posts '{}' to "/authors"
    Then the status should be 400

  Scenario: View an author
    Given an author with name "Brandon Sanderson"
    And a book with author "Brandon Sanderson"
    And a user requests "/authors/brandon-sanderson"
    Then the status should be 200
    And the response should have "name" "Brandon Sanderson"
    And the response should have a "self" link to "/authors/brandon-sanderson"
    And the response should have a "books" link to "/authors/brandon-sanderson/books"

  Scenario: Author does not exist
    Given a user requests "/authors/brandon-sanderson"
    Then the status should be 404

  Scenario: Edit an author
    Given an author with name "Brandon Sanderson"
    And a user puts '{"name": "George R. R. Martin"}' to "/authors/brandon-sanderson"
    Then the status should be 200
    And the response should have "name" "George R. R. Martin"
    And the response should have a "self" link to "/authors/george-r-r-martin"

  Scenario: Delete an author
    Given an author with name "Brandon Sanderson"
    And a user deletes "/authors/brandon-sanderson"
    Then the status should be 204
