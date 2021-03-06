Feature: Authentication
  As a user
  I want to sign up and authenticate
  So I can access my own data

  Scenario: Signup
    Given a user posts '{"username": "tom", "password": "password"}' to "/signup"
    Then the status should be 201
    And the response should have a "self" link to "/users/tom"
    And the response should have "username" "tom"
    And the response should have jwt with "username" "tom"

  Scenario: Signin
    Given a user with username "tom" and password "password"
    And a user posts '{"username": "tom", "password": "password"}' to "/signin"
    Then the status should be 200
    And the response should have a "self" link to "/users/tom"
    And the response should have "username" "tom"
    And the response should have jwt with "username" "tom"

  Scenario: Invalid signin
    Given a user with username "tom" and password "password"
    And a user posts '{"username": "tom", "password": "wrong"}' to "/signin"
    Then the status should be 400

  Scenario: Get user account
    Given a user with username "tom" and password "password"
    And a user requests "/users/tom"
    Then the status should be 401

  Scenario: Get user account of logged in user
    Given a user with username "tom" and password "password"
    And a user requests "/users/tom" with a token for username "tom"
    Then the status should be 200
    And the response should have a "self" link to "/users/tom"
    And the response should have "username" "tom"
    And the response should have jwt with "username" "tom"

  Scenario: Get user account of different in user
    Given a user with username "tom" and password "password"
    Given a user with username "bob" and password "password"
    And a user requests "/users/tom" with a token for username "bob"
    Then the status should be 403

  Scenario: Get user with invalid auth header account
    Given a user with username "tom" and password "password"
    And a user requests "/users/tom" with a different scheme
    Then the status should be 401
