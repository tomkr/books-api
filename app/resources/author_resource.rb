require 'webmachine'
require './app/models/author'
require './app/resources/render'

# A webmachine resource for the collection of books.
class AuthorResource < Webmachine::Resource
  include Render

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

  def author
    @author ||= Author.find_by(id: id)
  end

  def id
    request.path_info[:id]
  end
end
