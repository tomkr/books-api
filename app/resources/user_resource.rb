# frozen_string_literal: true
require 'jwt'
require './app/resources/base_resource'
require './app/models/user'
require './app/resources/authenticateable'

# Resource for getting user data.
class UserResource < BaseResource
  include Authenticateable

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
