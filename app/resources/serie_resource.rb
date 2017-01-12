require 'webmachine'
require './app/models/serie'
require './app/resources/render'

# A webmachine resource representing a serie.
class SerieResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def resource_exists?
    serie
  end

  private

  def to_json
    render(template: 'serie',
           locals: {
             serie: serie,
             books: serie.books
           })
  end

  def serie
    @serie ||= Serie.find_by(slug: slug)
  end

  def slug
    request.path_info[:id]
  end
end
