# frozen_string_literal: true
require 'rack/test'
require 'webmachine/adapters/rack'
require 'factory_girl'
require 'pry'
ENV['DATABASE_URL'] = ENV['TEST_DATABASE_URL']
require './app'

# Helper module that runs the app as Rack app for tests.
module AppHelpers
  include Rack::Test::Methods
  include Sluggify

  App.configure do |config|
    config.adapter = :Rack
  end

  def app
    App.adapter
  end

  def parsed_response
    JSON.parse(last_response.body)
  end

  FactoryGirl.find_definitions
end

World(AppHelpers, FactoryGirl::Syntax::Methods)
