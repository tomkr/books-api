require 'webmachine'
require './app/models/book'
require './app/resources/render'

# A webmachine resource representing a book.
class BookResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET PUT DELETE)
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def delete_resource
    book.destroy
  end

  def resource_exists?
    book
  end

  private

  def from_json
    book.update(JSON.parse(request.body.to_s))
    response.body = render(template: 'book', locals: { book: book })
  end

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
