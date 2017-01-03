require 'rack/test'
require 'webmachine/adapters/rack'
require 'factory_girl'
ENV['ENV'] = 'test'
require './app'

# Helper module that runs the app as Rack app for tests.
module AppHelpers
  include Rack::Test::Methods

  App.configure do |config|
    config.adapter = :Rack
  end

  def app
    App.adapter
  end

  FactoryGirl.find_definitions
end

World(AppHelpers, FactoryGirl::Syntax::Methods)
