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
