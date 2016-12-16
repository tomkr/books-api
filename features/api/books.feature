Feature: Books
  As a user
  I want to browse the books database
  So I can update my collection

  Scenario: List books
    Given a couple of books
    And a user requests a list of books
    Then the response should contain "title"
