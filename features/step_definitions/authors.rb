Given(/^an author with name "([^"]*)"$/) do |name|
  create(:author, name: name, slug: Sluggify.sluggify(name))
end
