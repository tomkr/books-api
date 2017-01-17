# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/serie'

# A webmachine resource representing a serie.
class SerieResource < BaseResource
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
    serie.destroy
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

  def from_json
    title = JSON.parse(request.body.to_s)['title']
    serie.update(title: title, slug: Sluggify.sluggify(title))
    response.body = to_json
  end

  def serie
    @serie ||= Serie.find_by(slug: slug)
  end

  def slug
    request.path_info[:id]
  end
end
