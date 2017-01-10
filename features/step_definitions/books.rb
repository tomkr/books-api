require './app/models/book'

Given(/^a book with title "([^"]*)"$/) do |title|
  create(:book, title: title)
end

Given(/^a book with author "([^"]*)"$/) do |author_name|
  create(:book, author: Author.find_by(name: author_name))
end

Given(/^a book with title "([^"]*)" by "([^"]*)"$/) do |title, author_name|
  create(:book, title: title, author: Author.find_by(name: author_name))
end

Given(/^a book with title "([^"]*)" in "([^"]*)"$/) do |title, serie_title|
  create(:book, title: title, serie: Serie.find_by(title: serie_title))
end
