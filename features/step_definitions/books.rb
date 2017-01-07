require './app/models/book'

Given(/^a book with title "([^"]*)"$/) do |title|
  create(:book, title: title)
end

Given(/^a book with author "([^"]*)"$/) do |author_name|
  create(:book, author: Author.find_by(name: author_name))
end
