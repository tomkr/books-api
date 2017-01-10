require 'webmachine'
require './app/models/book'
require './app/resources/render'

# A webmachine resource for the collection of books.
class BooksResource < Webmachine::Resource
  include Render

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
    response.body = render(template: 'book', locals: { book: book })
  end

  def to_json
    render(template: 'books',
           locals: {
             books: Book.all,
             self_link: '/books'
           })
  end

  def book
    @book ||= Book.create(JSON.parse(request.body.to_s)
      .merge(slug: 'test-slug'))
  end

  def next_id
    @id ||= Book.maximum(:id) ? Book.maximum(:id).next : 1
  end

  def invalid
    response.body = book.errors.to_json
    400
  end
end
