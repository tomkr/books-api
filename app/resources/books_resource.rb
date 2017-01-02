require 'json'
require 'webmachine'
require './app/models/book'

# A webmachine resource representing a book.
class BooksResource < Webmachine::Resource
  def allowed_methods
    ['POST']
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def post_is_create?
    true
  end

  def create_path
    "/books/#{next_id}"
  end

  private

  def from_json
    response.body = book.attributes.merge(_links: links).to_json
  end

  def book
    @book ||= Book.create(JSON.parse(request.body.to_s))
  end

  def links
    {
      self: {
        href: "/books/#{next_id}"
      }
    }
  end

  def next_id
    @id ||= Book.maximum(:id) ? Book.maximum(:id).next : 1
  end
end
