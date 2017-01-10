require 'webmachine'
require './app/models/serie'
require './app/resources/render'

# A webmachine resource for the collection of series.
class SeriesResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  private

  def to_json
    render(template: 'series',
           locals: {
             series: Serie.all,
             self_link: '/series'
           })
  end
end
