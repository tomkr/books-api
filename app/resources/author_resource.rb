require 'webmachine'
require './app/models/author'
require './app/resources/render'

# A webmachine resource for the collection of books.
class AuthorResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET PUT)
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def resource_exists?
    author
  end

  private

  def to_json
    render(template: 'author', locals: { author: author })
  end

  def from_json
    author.update(JSON.parse(request.body.to_s))
    response.body = render(template: 'author', locals: { author: author })
  end

  def author
    @author ||= Author.find_by(id: id)
  end

  def id
    request.path_info[:id]
  end
end
