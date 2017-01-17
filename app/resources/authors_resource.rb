# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/author'

# A webmachine resource for the collection of authors.
class AuthorsResource < BaseResource
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
    @slug ||= Sluggify.sluggify(params['name'])
  end

  def to_json
    render(template: 'authors', locals: { authors: Author.all })
  end
end
