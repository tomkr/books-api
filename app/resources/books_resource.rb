require 'webmachine'
require './app/models/book'
require './app/resources/render'
require './app/sluggify'

# A webmachine resource for the collection of books.
class BooksResource < Webmachine::Resource
  include Render
  include Sluggify

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
    "/books/#{slug}"
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
    @book ||= Book.create(params.merge(slug: slug))
  end

  def slug
    @slug ||= params['title'] ? sluggify(params['title']) : ''
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def invalid
    response.body = book.errors.to_json
    400
  end
end
