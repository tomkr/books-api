require 'json'
require 'tilt/jbuilder'
require 'webmachine'
require './app/models/book'

# A webmachine resource representing a book.
class BookResource < Webmachine::Resource
  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def resource_exists?
    book
  end

  private

  def to_json
    template = Tilt::JbuilderTemplate.new('app/templates/book.json.jbuilder')
    template.render nil, book: book
  end

  def book
    @book ||= Book.find_by(id: id)
  end

  def id
    request.path_info[:id]
  end
end
