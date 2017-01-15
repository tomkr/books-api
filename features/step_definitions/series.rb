Given(/^a series? with title "([^"]*)"$/) do |title|
  create(:serie, title: title, slug: Sluggify.sluggify(title))
end
