# frozen_string_literal: true
require 'jwt'

# Representation of a logged in user backed by a database.
class User < ActiveRecord::Base
  def jwt
    @jwt ||= JWT.encode({ username: username }, 'secret', 'HS256')
  end
end
