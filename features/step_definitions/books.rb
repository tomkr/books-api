require './app/models/book'

Given(/^a book with title "([^"]*)"$/) do |title|
  Book.create(title: title)
end

Given(/^a user requests "([^"]*)"$/) do |path|
  get path
end

Given(/^a user posts '([^']*)' to "([^"]*)"$/) do |body, path|
  post path, body, 'CONTENT_TYPE' => 'application/json'
end

Then(/^the response should have "([^"]*)" "([^"]*)"$/) do |key, value|
  expect(parsed_response[key]).to eq(value)
end

Then(/^the response should have a "([^"]*)" link to "([^"]*)"$/) do |key, path|
  expect(parsed_response['_links'][key]['href']).to eq(path)
end

Then(/^the status should be (\d+)$/) do |code|
  expect(last_response.status).to eq(code.to_i)
end

def parsed_response
  JSON.parse(last_response.body)
end
