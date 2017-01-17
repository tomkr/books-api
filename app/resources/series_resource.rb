# frozen_string_literal: true
require './app/models/serie'
require './app/resources/base_resource'

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
    "/series/#{slug}"
  end

  private

  def from_json
    serie.save
    response.body = render(template: 'serie', locals: { serie: serie })
  end

  def to_json
    render(template: 'series',
           locals: {
             series: Serie.all,
             self_link: '/series'
           })
  end

  def serie
    @serie ||= Serie.new(params
      .merge('slug' => Sluggify.sluggify(params['title'])))
  end

  def params
    @params ||= JSON.parse(request.body.to_s)
  end

  def slug
    @slug = serie.slug
  end
end
