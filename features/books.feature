Feature: Books
  As a user
  I want to browse the books database
  So I can update my collection

  Scenario: List books
    Given a book with title "The Final Empire"
    And a user requests "/books"
    Then the status should be 200
    And the response should have a "self" link to "/books"
    And the response has embedded "books" with
      | title            |
      | The Final Empire |
    And the first of "books" has a "self" link to "/books/the-final-empire"

  Scenario: List books for a specific author
    Given an author with name "Brandon Sanderson"
    And a book with title "The Final Empire" by "Brandon Sanderson"
    And a book with title "Game of Thrones"
    And a user requests "authors/brandon-sanderson/books"
    Then the status should be 200
    And the response should have a "self" link to "authors/brandon-sanderson/books"
    And the response has embedded "books" with
      | title            |
      | The Final Empire |

  Scenario: View a book
    Given a book with title "Title"
    And a user requests "/books/title"
    Then the status should be 200
    And the response should have "title" "Title"
    And the response should have a "self" link to "/books/title"

  Scenario: View a book in a series
    Given a series with title "Mistborn"
    Given a book with title "The Final Empire" in "Mistborn"
    And a user requests "/books/the-final-empire"
    Then the response should have a "serie" link to "/series/1"

  Scenario: Book does not exist
    Given a user requests "/books/title"
    Then the status should be 404

  Scenario: Add a book
    Given an author with name "Brandon Sanderson"
    And a user posts '{"title": "Title", "author_id": "brandon-sanderson"}' to "/books"
    Then the status should be 201
    And the response should have "title" "Title"
    And the response should have a "self" link to "/books/title"

  Scenario: Add a malformed book
    Given a user posts '{}' to "/books"
    Then the status should be 400

  Scenario: Edit a book
    Given a book with title "A Game of Thrones"
    And a user puts '{"title": "The Winds of Winter"}' to "/books/a-game-of-thrones"
    Then the status should be 200
    And the response should have "title" "The Winds of Winter"
    And the response should have a "self" link to "/books/the-winds-of-winter"

  Scenario: Delete a book
    Given a book with title "A Game of Thrones"
    And a user deletes "/books/a-game-of-thrones"
    Then the status should be 204
