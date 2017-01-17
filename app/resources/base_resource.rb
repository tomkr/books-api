# frozen_string_literal: true
require 'webmachine'
require './app/resources/render'
require './app/sluggify'

# Base resource that does some setup for all other resources through
# inheritance.
class BaseResource < Webmachine::Resource
  include Render

  def finish_request
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers['Access-Control-Allow-Methods'] = allowed_methods.join(',')
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end
end
