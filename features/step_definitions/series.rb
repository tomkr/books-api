require './app/models/serie'

Given(/^a series with title "([^"]*)"$/) do |title|
  create(:serie, title: title, slug: sluggify(title))
end
