# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/book'
require './app/lib/books_query'

# A webmachine resource for the collection of books.
class BooksResource < BaseResource
  def allowed_methods
    %w(GET OPTIONS POST)
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
    "/books/#{book.slug}"
  end

  private

  def from_json
    return invalid unless book.valid?
    response.body = render(template: 'book', locals: { book: book })
  end

  def to_json
    render(template: 'books',
           locals: {
             books: query.execute,
             author: query.author,
             serie: query.serie
           })
  end

  def book
    @book ||= Book.new(params
      .merge(
        slug: Sluggify.sluggify(params['title']),
        author: Author.find_by(slug: params['author_id'])
      ))
  end

  def books
    @books ||= Book.where(search_query)
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def query
    @query ||= BooksQuery.new(request.query.slice('author', 'serie')
      .symbolize_keys)
  end

  def invalid
    response.body = book.errors.to_json
    400
  end
end
