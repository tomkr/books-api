Feature: Series
  As a user
  I want to browse the series database
  So I can find upcoming the next book in a series

  Scenario: List series
    Given a series with title "Mistborn"
    And a user requests "/series"
    Then the status should be 200
    And the response should have a "self" link to "/series"
    And the response has embedded "series" with
      | title    |
      | Mistborn |

  Scenario: View serie
    Given a series with title "Mistborn"
    And a book with title "The Final Empire" in "Mistborn"
    And a user requests "/series/1"
    Then the status should be 200
    And the response should have "title" "Mistborn"
    And the response should have a "self" link to "/series/1"
    And the response should have a "books" link to "/series/1/books"
    And the response should have a "first_book" link to "/books/1"
