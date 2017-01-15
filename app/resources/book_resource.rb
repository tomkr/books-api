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
    book.update(update_params)
    response.body = render(template: 'book', locals: { book: book })
  end

  def to_json
    render(template: 'book', locals: { book: book })
  end

  def author
    @author ||= Author.find_by(slug: params['author_id'])
  end

  def book
    @book ||= Book.find_by(slug: slug)
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def update_params
    @update_params ||= {
      title: params['title'],
      author: author,
      slug: Sluggify.sluggify(params['title'])
    }
  end

  def slug
    request.path_info[:id]
  end
end
