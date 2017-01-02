require './app'
require 'active_record'
require 'rack/test'
require 'webmachine/adapters/rack'

# Helper module that runs the app as Rack app for tests.
module AppHelpers
  include Rack::Test::Methods

  config_dir = File.expand_path('../../../config', __FILE__)
  ActiveRecord::Base.configurations =
    YAML.load(File.read(File.join(config_dir, 'database.yml')))
  ActiveRecord::Base.establish_connection :test

  App.configure do |config|
    config.adapter = :Rack
  end

  def app
    App.adapter
  end
end

World(AppHelpers)
