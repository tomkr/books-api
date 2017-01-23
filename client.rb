# frozen_string_literal: true
require 'thor'
require './client/client'

# CLI Client for the API.
class Client < Thor
  desc 'books', 'manage books'
  subcommand 'books', Books

  desc 'authors', 'manage authors'
  subcommand 'authors', Authors

  desc 'series', 'manage series'
  subcommand 'series', Series
end
