require './app'
require 'rack/test'
require 'webmachine/adapters/rack'

# Helper module that runs the app as Rack app for tests.
module AppHelpers
  include Rack::Test::Methods
  App.configure do |config|
    config.adapter = :Rack
  end

  def app
    App.adapter
  end
end

World(AppHelpers)
