# frozen_string_literal: true
require 'thor'
require './app/lib/sluggify'
require './client/api_client'

# Subcommands to do with the books endpoints.
class Books < Thor
  include API

  desc 'list', 'List all books'
  option :author
  option :serie
  def list
    puts api.books(to_params(options)).get.map(&:title).join("\n")
  end

  desc 'add TITLE AUTHOR [SERIE] [POSITION]',
       'Add a book written by an author'
  def add(title, author_name, serie_name = nil, position = nil)
    author = Sluggify.sluggify(author_name)
    serie = Sluggify.sluggify(serie_name)
    book = api.books.post(title: title, author_id: author, serie_id: serie,
                          position: position).body
    puts "#{book['title']} has been added"
  end

  desc 'edit TITLE NEW_TITLE NEW_AUTHOR [NEW_SERIE] [NEW_POSITION]',
       'Edit an existing book'
  def edit(title, new_title, author_name, serie_name = nil, position = nil)
    author = Sluggify.sluggify(author_name)
    serie = Sluggify.sluggify(serie_name)
    book = find_by_title(title)
    return puts "#{title} not found" if book.nil?
    new_book = book.put(title: new_title, author_id: author, serie_id: serie,
                        position: position).body
    puts "#{new_book['title']} has been updated"
  end

  desc 'delete TITLE', 'Remove an existing book'
  def delete(title)
    book = find_by_title(title)
    return puts "#{title} not found" if book.nil?
    book.delete
    puts "#{title} has been removed"
  end

  private

  def find_by_title(title)
    api.books.get.select { |b| b.title == title }.first
  end

  def to_params(options)
    params = {}
    params[:author] = Sluggify.sluggify(options[:author]) if options[:author]
    params[:serie] = Sluggify.sluggify(options[:serie]) if options[:serie]
    params
  end
end
