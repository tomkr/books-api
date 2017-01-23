# frozen_string_literal: true
require 'thor'
require './client/api_client'

# Subcommands to do with the books endpoints.
class Series < Thor
  desc 'list', 'List all series'
  def list
    puts client.series.get.map(&:title).join("\n")
  end

  private

  def client
    @client ||= APIClient.new
  end
end
