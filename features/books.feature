Feature: Books
  As a user
  I want to browse the books database
  So I can update my collection

  Scenario: View a book
    Given a book with title "Title"
    And a user requests "/books/1"
    Then the status should be 200
    And the response should have "title" "Title"
    And the response should have a "self" link to "/books/1"

  Scenario: Book does not exist
    Given a user requests "/books/1"
    Then the status should be 404

  Scenario: Add a book
    Given a user posts '{"title": "Title"}' to "/books"
    Then the status should be 201
    And the response should have "title" "Title"
    And the response should have a "self" link to "/books/1"
