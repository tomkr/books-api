Feature: API
  As a user
  I want to browse the API
  So I know what endpoints there are

  Scenario: Access API
    Given a user requests "/"
    Then the status should be 200
    And the response should have a "self" link to "/"
    And the response should have a "books" link to "/books"
    And the response should have an "authors" link to "/authors"
