require 'webmachine'
require './app/models/author'
require './app/resources/render'

# A webmachine resource for the collection of authors.
class AuthorsResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  private

  def to_json
    render(template: 'authors', locals: { authors: Author.all })
  end
end
