# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/book'

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

  def author
    @author ||= Author.find_by(slug: params['author_id'])
  end

  def book
    @book ||= Book.create(params.select { |k, _| ['title'].include? k }
                  .merge(slug: slug, author: author))
  end

  def slug
    @slug ||= params['title'] ? Sluggify.sluggify(params['title']) : ''
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def invalid
    response.body = book.errors.to_json
    400
  end
end
