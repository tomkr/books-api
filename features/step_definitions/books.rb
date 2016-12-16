Given(/^a couple of books$/) do
end

Given(/^a user requests a list of books$/) do
  get '/'
end

Then(/^the response should contain "([^"]*)"$/) do |contents|
  last_response.include?(contents)
end
