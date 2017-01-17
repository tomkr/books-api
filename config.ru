# frozen_string_literal: true
require 'webmachine/adapter'
require 'webmachine/adapters/rack'
require './app'

App.configure do |config|
  config.adapter = :Rack
end

run App.adapter
