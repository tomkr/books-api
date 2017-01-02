require 'json'
require 'webmachine'
require './app/models/book'

# A webmachine resource representing a book.
class BooksResource < Webmachine::Resource
  def allowed_methods
    %w(GET POST)
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def post_is_create?
    true
  end

  def create_path
    "/books/#{next_id}"
  end

  private

  def from_json
    return invalid unless book.valid?
    response.body = book.attributes.merge(_links: links).to_json
  end

  def to_json
    {
      _links: {
        self: {
          href: '/books'
        }
      },
      _embedded: {
        books: Book.all
      }
    }.to_json
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

  def invalid
    response.body = book.errors.to_json
    400
  end
end
