Feature: Books
  As a user
  I want to browse the books database
  So I can update my collection

  Scenario: View a book
    Given a book with title "Title"
    And a user requests "/books/1"
    Then the response should have "title" "Title"
    And the response should have a link to self
