# Collection of step definitions to do with handling general requests and
# responses.

Given(/^a user requests "([^"]*)"$/) do |path|
  get path
end

Given(/^a user posts '([^']*)' to "([^"]*)"$/) do |body, path|
  post path, body, 'CONTENT_TYPE' => 'application/json'
end

Given(/^a user puts '([^']*)' to "([^"]*)"$/) do |body, path|
  put path, body, 'CONTENT_TYPE' => 'application/json'
end

Given(/^a user deletes "([^"]*)"$/) do |path|
  delete path
end

Then(/^the response should have "([^"]*)" "([^"]*)"$/) do |key, value|
  expect(parsed_response[key]).to eq(value)
end

Then(/^the response should have an? "([^"]*)" link to "([^"]*)"$/) do |key, path|
  expect(parsed_response['_links'][key]['href']).to eq(path)
end

Then(/^the status should be (\d+)$/) do |code|
  expect(last_response.status).to eq(code.to_i)
end

Then(/^the response has embedded "([^"]*)" with$/) do |list, table|
  list = parsed_response['_embedded'][list]
  hashes = table.hashes
  keys = hashes.first.keys
  keys.each do |k|
    expect(hashes.map { |v| v.fetch(k) })
      .to match_array(list.map { |v| v.fetch(k) })
  end
end

def parsed_response
  JSON.parse(last_response.body)
end
