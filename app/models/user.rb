# frozen_string_literal: true
require 'jwt'

# Representation of a logged in user backed by a database.
class User < ActiveRecord::Base
  def jwt
    @jwt ||= JWT.encode({ username: username }, ENV.fetch('AUTH_SECRET'),
                        'HS256')
  end
end
