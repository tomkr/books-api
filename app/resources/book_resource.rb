require 'webmachine'
require './app/models/book'
require './app/resources/render'

# A webmachine resource representing a book.
class BookResource < Webmachine::Resource
  include Render

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def resource_exists?
    book
  end

  private

  def to_json
    render(template: 'book', locals: { book: book })
  end

  def book
    @book ||= Book.find_by(id: id)
  end

  def id
    request.path_info[:id]
  end
end
