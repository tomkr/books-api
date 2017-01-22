# frozen_string_literal: true
require './app/resources/base_resource'

# A webmachine resource for the collection of books.
class ApiResource < BaseResource
  def allowed_methods
    %w(OPTIONS GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  private

  def to_json
    render(template: 'api')
  end
end
