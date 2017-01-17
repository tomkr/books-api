# frozen_string_literal: true
require 'webmachine'
require './db/config'
require './app/resources'

App = Webmachine::Application.new do |app|
  app.routes do
    add [], ApiResource
    add ['authors'], AuthorsResource
    add ['authors', :id], AuthorResource
    add ['authors', :id, 'books'], AuthorBooksResource
    add ['books'], BooksResource
    add ['books', :id], BookResource
    add ['series'], SeriesResource
    add ['series', :id], SerieResource
  end
end
