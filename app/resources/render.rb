# frozen_string_literal: true
require 'tilt/jbuilder'

# Provides an easier render method for resources that need it.
module Render
  def render(template:, locals: {})
    template = Tilt::JbuilderTemplate.new(
      "app/templates/#{template}.json.jbuilder"
    )
    template.render nil, locals
  end
end
