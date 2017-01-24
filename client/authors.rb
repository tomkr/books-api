# frozen_string_literal: true
require 'thor'
require './client/api_client'

# Subcommands to do with the books endpoints.
class Authors < Thor
  desc 'list', 'List all authors'
  def list
    puts client.authors.get.map(&:name).join("\n")
  end

  desc 'add NAME', 'Add an author'
  def add(name)
    author = client.authors.post(name: name).body
    puts "#{author['name']} has been added"
  end

  desc 'edit NAME NEW_NAME', 'Edit an existing author'
  def edit(name, new_name)
    author = find_by_name(name)
    return puts "#{name} not found" if author.nil?
    new_author = author.put(name: new_name).body
    puts "#{new_author['name']} has been updated"
  end

  desc 'delete NAME', 'Remove an existing author'
  def delete(name)
    author = find_by_name(name)
    return puts "#{name} not found" if author.nil?
    author.delete
    puts "#{name} has been removed"
  end

  private

  def find_by_name(name)
    client.authors.get.select { |a| a.name == name }.first
  end

  def client
    @client ||= APIClient.new
  end
end
