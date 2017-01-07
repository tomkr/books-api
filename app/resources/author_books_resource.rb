require 'webmachine'
require './app/models/author'
require './app/models/book'
require './app/resources/render'

# A webmachine resource for the collection of books by a single author.
class AuthorBooksResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  private

  def to_json
    render(template: 'books',
           locals: {
             books: books,
             self_link: "authors/#{author_id}/books"
           })
  end

  def books
    @books ||= Book.where(author: author_id)
  end

  def author_id
    request.path_info[:id]
  end
end
