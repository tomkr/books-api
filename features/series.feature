Feature: Series
  As a user
  I want to browse the series database
  So I can find upcoming the next book in a series

  Scenario: List series
    Given a serie titled "Mistborn"
    And a user requests "/series"
    Then the status should be 200
    And the response should have a "self" link to "/series"
    And the response has embedded "series" with
      | title    |
      | Mistborn |

  Scenario: View serie
    Given a serie titled "Mistborn"
    And a book with title "The Final Empire" in "Mistborn"
    And a user requests "/series/mistborn"
    Then the status should be 200
    And the response should have "title" "Mistborn"
    And the response should have a "self" link to "/series/mistborn"
    And the response should have a "books" link to "/series/mistborn/books"
    And the response should have a "first_book" link to "/books/the-final-empire"

  Scenario: Add a serie
    Given a user posts '{"title": "Mistborn"}' to "/series"
    Then the status should be 201
    And the response should have "title" "Mistborn"
    And the response should have a "self" link to "/series/mistborn"

  Scenario: Add a malformed serie
    Given a user posts '{}' to "/series"
    Then the status should be 400

  Scenario: Update a serie
    Given a serie titled "Mistborn"
    And a user puts '{"title": "The Reckoners"}' to "/series/mistborn"
    Then the status should be 200
    And the response should have "title" "The Reckoners"
    And the response should have a "self" link to "/series/the-reckoners"

  Scenario: Update a malformed serie
    Given a serie titled "Mistborn"
    And a user puts '{}' to "/series/mistborn"
    Then the status should be 400

  Scenario: Delete a serie
    Given a serie titled "Mistborn"
    And a user deletes "/series/mistborn"
    Then the status should be 204
