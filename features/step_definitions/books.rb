require './app/models/book'

Given(/^a book with title "([^"]*)"$/) do |title|
  Book.create(title: title)
end

Given(/^a user requests "([^"]*)"$/) do |path|
  get path
end

Then(/^the response should have "([^"]*)" "([^"]*)"$/) do |key, value|
  expect(parsed_response[key]).to eq(value)
end

Then(/^the response should have a link to self$/) do
  expect(parsed_response['_links']['self']['href']).to eq(last_request.path)
end

def parsed_response
  JSON.parse(last_response.body)
end
