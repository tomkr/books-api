# frozen_string_literal: true
require 'webmachine'
require './app/models/author'
require './app/resources/render'
require './app/sluggify'

# A webmachine resource for the collection of books.
class AuthorResource < Webmachine::Resource
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
    author.destroy
  end

  def resource_exists?
    author
  end

  private

  def to_json
    render(template: 'author', locals: { author: author })
  end

  def from_json
    author.update(params.merge(slug: Sluggify.sluggify(params['name'])))
    response.body = render(template: 'author', locals: { author: author })
  end

  def author
    @author ||= Author.find_by(slug: slug)
  end

  def params
    JSON.parse(request.body.to_s)
  end

  def slug
    request.path_info[:id]
  end
end
