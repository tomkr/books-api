# frozen_string_literal: true
require 'jwt'
require './app/resources/base_resource'
require './app/models/user'

# Resource for getting user data.
class UserResource < BaseResource
  AUTH_MESSAGE = 'Bearer error="invalid_token"'

  def is_authorized?(authorization_header)
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
    return true unless resource_exists?
    authenticated_user != user.username
  end

  def allowed_methods
    %w(OPTIONS GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def resource_exists?
    user
  end

  private

  attr_reader :authenticated_user

  def to_json
    render(template: 'user', locals: { user: user })
  end

  def user
    @user ||= User.find_by(username: username)
  end

  def username
    @username ||= request.path_info[:username]
  end
end
