# frozen_string_literal: true
require 'thor'
require './app/lib/sluggify'
require './client/api_client'

# Subcommands to do with the books endpoints.
class Books < Thor
  desc 'list', 'List all books'
  option :author
  option :serie
  def list
    puts client.books(to_params(options)).get.map(&:title).join("\n")
  end

  private

  def to_params(options)
    params = {}
    params[:author] = Sluggify.sluggify(options[:author]) if options[:author]
    params[:serie] = Sluggify.sluggify(options[:serie]) if options[:serie]
    params
  end

  def client
    @client ||= APIClient.new
  end
end
