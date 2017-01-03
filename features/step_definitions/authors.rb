require './app/models/author'

Given(/^an author with name "([^"]*)"$/) do |name|
  create(:author, name: name)
end
