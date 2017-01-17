# frozen_string_literal: true
require 'webmachine'
require './app/resources/render'

# A webmachine resource for the collection of books.
class ApiResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  private

  def to_json
    render(template: 'api')
  end
end
