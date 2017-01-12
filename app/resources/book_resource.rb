require 'webmachine'
require './app/models/book'
require './app/resources/render'
require './app/sluggify'

# A webmachine resource representing a book.
class BookResource < Webmachine::Resource
  include Render
  include Sluggify

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
    book.update(params.merge(slug: sluggify(params['title'])))
    response.body = render(template: 'book', locals: { book: book })
  end

  def to_json
    render(template: 'book', locals: { book: book })
  end

  def book
    @book ||= Book.find_by(slug: slug)
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def slug
    request.path_info[:id]
  end
end
