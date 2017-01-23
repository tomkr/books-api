# frozen_string_literal: true
require 'webmachine'
require './db/config'
require './app/resources'

App = Webmachine::Application.new do |app|
  app.routes do
    add [], ApiResource
    add ['authors'], AuthorsResource
    add ['authors', :slug], AuthorResource
    add ['books'], BooksResource
    add ['books', :slug], BookResource
    add ['series'], SeriesResource
    add ['series', :slug], SerieResource
    add ['signin'], SigninResource
    add ['signup'], SignupResource
    add ['users', :username], UserResource
  end
end
