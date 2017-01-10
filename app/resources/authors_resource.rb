require 'webmachine'
require './app/models/author'
require './app/resources/render'

# A webmachine resource for the collection of authors.
class AuthorsResource < Webmachine::Resource
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
    "/authors/#{next_id}"
  end

  private

  def author
    @author ||= Author.create(JSON.parse(request.body.to_s)
      .merge(slug: 'test-slug'))
  end

  def from_json
    response.body = render(template: 'author', locals: { author: author })
  end

  def next_id
    @id ||= Author.maximum(:id) ? Author.maximum(:id).next : 1
  end

  def to_json
    render(template: 'authors', locals: { authors: Author.all })
  end
end
