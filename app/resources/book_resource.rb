require 'json'
require 'webmachine'
require './app/models/book'

# A webmachine resource representing a book.
class BookResource < Webmachine::Resource
  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def to_json
    book.attributes.merge(_links: links).to_json
  end

  def resource_exists?
    book
  end

  private

  def book
    @book ||= Book.find_by(id: id)
  end

  def links
    {
      self: {
        href: "/books/#{id}"
      }
    }
  end

  def id
    request.path_info[:id]
  end
end
