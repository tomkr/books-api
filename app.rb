require 'webmachine'
require './app/resources'

App = Webmachine::Application.new do |app|
  app.routes do
    add ['books', :id], BookResource
  end
end
