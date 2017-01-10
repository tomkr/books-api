require 'active_record'
require 'webmachine'
require './app/resources'

App = Webmachine::Application.new do |app|
  config_dir = File.expand_path('../config', __FILE__)
  ActiveRecord::Base.configurations =
    YAML.load(File.read(File.join(config_dir, 'database.yml')))
  ActiveRecord::Base.establish_connection(
    ENV.fetch('ENV', 'development').to_sym
  )

  app.routes do
    add [], ApiResource
    add ['authors'], AuthorsResource
    add ['authors', :id], AuthorResource
    add ['authors', :id, 'books'], AuthorBooksResource
    add ['books'], BooksResource
    add ['books', :id], BookResource
    add ['series'], SeriesResource
  end
end
