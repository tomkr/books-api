Feature: Authentication
  As a user
  I want to sign up and authenticate
  So I can access my own data

  Scenario: Signup
    Given a user posts '{"username": "tom", "password": "password"}' to "/signup"
    Then the status should be 201
    And the response should have a "self" link to "/users/tom"
    And the response should have "username" "tom"
    And the response should have "jwt"
