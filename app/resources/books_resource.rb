require 'json'
require 'tilt/jbuilder'
require 'webmachine'
require './app/models/book'

# A webmachine resource for the collection of books.
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
    template = Tilt::JbuilderTemplate.new('app/templates/book.json.jbuilder')
    response.body = template.render(nil, book: book)
  end

  def to_json
    template = Tilt::JbuilderTemplate.new('app/templates/books.json.jbuilder')
    template.render nil, books: Book.all
  end

  def book
    @book ||= Book.create(JSON.parse(request.body.to_s))
  end

  def next_id
    @id ||= Book.maximum(:id) ? Book.maximum(:id).next : 1
  end

  def invalid
    response.body = book.errors.to_json
    400
  end
end
