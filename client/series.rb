# frozen_string_literal: true
require 'thor'
require './client/api_client'

# Subcommands to do with the books endpoints.
class Series < Thor
  desc 'list', 'List all series'
  def list
    puts client.series.get.map(&:title).join("\n")
  end

  desc 'add TITLE', 'Add a serie'
  def add(title)
    serie = client.series.post(title: title).body
    puts "#{serie['title']} has been added"
  end

  desc 'edit TITLE NEW_TITLE', 'Edit an existing serie'
  def edit(title, new_title)
    serie = find_by_title(title)
    return puts "#{title} not found" if serie.nil?
    new_serie = serie.put(title: new_title).body
    puts "#{new_serie['title']} has been updated"
  end

  desc 'delete TITLE', 'Remove an existing serie'
  def delete(title)
    serie = find_by_title(title)
    return puts "#{title} not found" if serie.nil?
    serie.delete
    puts "#{title} has been removed"
  end

  private

  def find_by_title(title)
    client.series.get.select { |s| s.title == title }.first
  end

  def client
    @client ||= APIClient.new
  end
end
