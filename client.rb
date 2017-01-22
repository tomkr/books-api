# frozen_string_literal: true
require 'hyperresource'
require 'thor'
require './app/lib/sluggify'

# Simple client for the API.
class APIClient < HyperResource
  self.root = 'http://localhost:8080'
  self.headers = { 'Content-Type' => 'application/json',
                   'Accept' => 'application/hal+json' }
end

# CLI Client for the API.
class Client < Thor
  desc 'books', 'List all books'
  def books
    puts client.books.get.map(&:title).join("\n")
  end

  desc 'authors', 'List all authors'
  def authors
    puts client.authors.get.map(&:name).join("\n")
  end

  desc 'series', 'List all series'
  def series
    puts client.series.get.map(&:title).join("\n")
  end

  desc 'by AUTHOR', 'Add a book to the database'
  def by(author)
    author = Sluggify.sluggify(author)
    puts client.books(author: author).get.map(&:title).join("\n")
  end

  private

  def client
    @client ||= APIClient.new
  end
end

Client.start(ARGV)
