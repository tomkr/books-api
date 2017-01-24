# frozen_string_literal: true
require 'thor'
require './client/client'

# CLI Client for the API.
class Client < Thor
  class_option :server
  desc 'books', 'manage books'
  subcommand 'books', Books

  desc 'authors', 'manage authors'
  subcommand 'authors', Authors

  desc 'series', 'manage series'
  subcommand 'series', Series
end
