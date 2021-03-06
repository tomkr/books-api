Feature: Books
  As a user
  I want to browse the books database
  So I can update my collection

  Scenario: List books
    Given a book with title "The Final Empire"
    And a user requests "/books"
    Then the status should be 200
    And the response should have a "self" link to "/books{?author,serie}"
    And the response has embedded "books" with
      | title            |
      | The Final Empire |
    And the first of "books" has a "self" link to "/books/the-final-empire"

  Scenario: List books for a specific author
    Given an author with name "Brandon Sanderson"
    And a book with title "The Final Empire" by "Brandon Sanderson"
    And a book with title "Game of Thrones"
    And a user requests "/books?author=brandon-sanderson"
    Then the status should be 200
    And the response should have a "self" link to "/books{?author,serie}"
    And the response should have an "author" link to "/authors/brandon-sanderson"
    And the response has embedded "books" with
      | title            |
      | The Final Empire |
    And the first of "books" has a "self" link to "/books/the-final-empire"

  Scenario: List books in a serie
    Given a serie titled "Mistborn"
    And a book with title "The Final Empire" in "Mistborn"
    And a user requests "/books?serie=mistborn"
    Then the status should be 200
    And the response should have a "self" link to "/books{?author,serie}"
    And the response should have a "serie" link to "/series/mistborn"
    And the response has embedded "books" with
      | title            |
      | The Final Empire |
    And the first of "books" has a "self" link to "/books/the-final-empire"

  Scenario: View a book
    Given a book with title "Title"
    And a user requests "/books/title"
    Then the status should be 200
    And the response should have "title" "Title"
    And the response should have a "self" link to "/books/title"

  Scenario: View a book in a series
    Given a serie titled "Mistborn"
    And a book with title "The Final Empire" in "Mistborn" at 1
    And a book with title "The Well of Ascension" in "Mistborn" at 2
    And a book with title "The Hero of Ages" in "Mistborn" at 3
    And a user requests "/books/the-well-of-ascension"
    Then the response should have a "serie" link to "/series/mistborn"
    And the response should have a "prev" link to "/books/the-final-empire"
    And the response should have a "next" link to "/books/the-hero-of-ages"

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
    Given an author with name "George R. R. Martin"
    And a book with title "A Game of Thrones" by "George R. R. Martin"
    And a user puts '{"title": "The Winds of Winter", "author_id": "george-r-r-martin"}' to "/books/a-game-of-thrones"
    Then the status should be 200
    And the response should have "title" "The Winds of Winter"
    And the response should have a "self" link to "/books/the-winds-of-winter"
    And the response should have an "author" link to "/authors/george-r-r-martin"

  Scenario: Add a malformed book
    Given an author with name "George R. R. Martin"
    And a book with title "A Game of Thrones" by "George R. R. Martin"
    And a user puts '{"title": "The Winds of Winter"}' to "/books/a-game-of-thrones"
    Then the status should be 400

  Scenario: Delete a book
    Given a book with title "A Game of Thrones"
    And a user deletes "/books/a-game-of-thrones"
    Then the status should be 204
