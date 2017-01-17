# frozen_string_literal: true
Given(
  /^a user with username "([^"]*)" and password "([^"]*)"$/
) do |username, password|
  create(:user, username: username, password: password)
end

Then(/^the response should have jwt with "([^"]*)" "([^"]*)"$/) do |key, value|
  jwt = parsed_response['jwt']
  decoded_jwt = JWT.decode jwt, 'secret', true, algorithm: 'HS256'
  expect(decoded_jwt.first[key]).to eq(value)
end
