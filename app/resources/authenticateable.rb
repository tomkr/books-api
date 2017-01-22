# frozen_string_literal: true

# Mixin that does setup for authenticating a user in a resource.
module Authenticateable
  AUTH_MESSAGE = 'Bearer error="invalid_token"'

  def is_authorized?(authorization_header)
    return true if request.method == 'OPTIONS' # Ajax OPTIONS lacks header.
    return AUTH_MESSAGE if authorization_header.blank?
    parsed_header = authorization_header.match(/^Bearer (.*)$/)
    return AUTH_MESSAGE if parsed_header.blank?
    jwt = parsed_header[1]
    decoded_jwt = JWT.decode(jwt, ENV.fetch('AUTH_SECRET'), true,
                             algorithm: 'HS256')
    @authenticated_user = decoded_jwt.first['username']
    authenticated_user.present?
  end

  def forbidden?
    return false if request.method == 'OPTIONS' # Ajax OPTIONS lacks header.
    return true unless resource_exists?
    authenticated_user != user.username
  end

  private

  attr_reader :authenticated_user
end
