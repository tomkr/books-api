require 'webmachine'
require './app/models/author'
require './app/resources/render'
require './app/sluggify'

# A webmachine resource for the collection of authors.
class AuthorsResource < Webmachine::Resource
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
    "/authors/#{slug}"
  end

  private

  def author
    @author ||= Author.create(params.merge(slug: slug))
  end

  def from_json
    response.body = render(template: 'author', locals: { author: author })
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def slug
    @slug ||= sluggify(params['name'])
  end

  def to_json
    render(template: 'authors', locals: { authors: Author.all })
  end
end
