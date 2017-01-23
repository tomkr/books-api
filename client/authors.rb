# frozen_string_literal: true
require 'thor'
require './client/api_client'

# Subcommands to do with the books endpoints.
class Authors < Thor
  desc 'list', 'List all authors'
  def list
    puts client.authors.get.map(&:name).join("\n")
  end

  private

  def client
    @client ||= APIClient.new
  end
end
