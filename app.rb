require 'webmachine'
require './app/book'

App = Webmachine::Application.new do |app|
  app.routes do
    add ['books', :id], Book
  end
end
