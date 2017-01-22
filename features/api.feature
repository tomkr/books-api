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
    And the response should have an "series" link to "/series"
    And the response should have an "signin" link to "/signin"
    And the response should have an "signup" link to "/signup"
    And the response should have an "user" link to "/users/{username}"
