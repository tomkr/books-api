Given(/^a couple of books$/) do
end

Given(/^a user requests a list of books$/) do
  @result = Book.all
end

Then(/^the response should contain "([^"]*)"$/) do |contents|
  @result.include?(contents)
end
