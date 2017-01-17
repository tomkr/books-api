# frozen_string_literal: true
Given(/^a serie titled "([^"]*)"$/) do |title|
  create(:serie, title: title, slug: Sluggify.sluggify(title))
end
