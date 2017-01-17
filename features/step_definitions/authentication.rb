# frozen_string_literal: true
Given(
  /^a user with username "([^"]*)" and password "([^"]*)"$/
) do |username, password|
  create(:user, username: username, password: password)
end

Given(
  /^a user requests "([^"]*)" with a token for username "([^"]*)"$/
) do |path, username|
  jwt = User.find_by(username: username).jwt
  header 'Authorization', "Bearer #{jwt}"
  get path
end

Given(/^a user requests "([^"]*)" with a different scheme$/) do |path|
  header 'Authorization', 'Test token'
  get path
end

Then(/^the response should have jwt with "([^"]*)" "([^"]*)"$/) do |key, value|
  jwt = parsed_response['jwt']
  decoded_jwt = JWT.decode(jwt, ENV.fetch('AUTH_SECRET'), true, algorithm:
                           'HS256')
  expect(decoded_jwt.first[key]).to eq(value)
end
