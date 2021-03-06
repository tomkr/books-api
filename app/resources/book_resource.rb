# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/book'

# A webmachine resource for a single book.
class BookResource < BaseResource
  def allowed_methods
    %w(OPTIONS GET PUT DELETE)
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
    return invalid unless book.update(update_params)
    response.body = render(template: 'book', locals: { book: book })
  end

  def to_json
    render(template: 'book', locals: { book: book })
  end

  def book
    @book ||= Book.find_by(slug: slug)
  end

  def params
    @params ||= JSON.parse(request.body.to_s).slice('title', 'author_id')
  end

  def update_params
    @update_params ||= {
      title: params['title'],
      author: Author.find_by(slug: params['author_id']),
      slug: Sluggify.sluggify(params['title'])
    }
  end

  def slug
    request.path_info[:slug]
  end

  def invalid
    response.body = book.errors.to_json
    400
  end
end
