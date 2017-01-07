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

  Scenario: Add an author
    Given a user posts '{"name": "George R. R. Martin"}' to "/authors"
    Then the status should be 201
    And the response should have "name" "George R. R. Martin"
    And the response should have a "self" link to "/authors/1"

  Scenario: View an author
    Given an author with name "Brandon Sanderson"
    And a book with author "Brandon Sanderson"
    And a user requests "/authors/1"
    Then the status should be 200
    And the response should have "name" "Brandon Sanderson"
    And the response should have a "self" link to "/authors/1"
    And the response should have a "books" link to "/authors/1/books"

  Scenario: Author does not exist
    Given a user requests "/authors/1"
    Then the status should be 404

  Scenario: Edit an author
    Given an author with name "Brandon Sanderson"
    And a user puts '{"name": "George R. R. Martin"}' to "/authors/1"
    Then the status should be 200
    And the response should have "name" "George R. R. Martin"
    And the response should have a "self" link to "/authors/1"
