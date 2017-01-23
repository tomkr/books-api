# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/serie'

# A webmachine resource for the collection of series.
class SeriesResource < BaseResource
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
    "/series/#{serie.slug}"
  end

  private

  def from_json
    return invalid unless serie.save
    response.body = render(template: 'serie', locals: { serie: serie })
  end

  def to_json
    render(template: 'series', locals: { series: Serie.all })
  end

  def serie
    @serie ||= Serie.new(
      params.merge(slug: Sluggify.sluggify(params['title']))
    )
  end

  def params
    @params ||= JSON.parse(request.body.to_s).slice('title')
  end

  def invalid
    response.body = serie.errors.to_json
    400
  end
end
