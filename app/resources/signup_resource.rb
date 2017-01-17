# frozen_string_literal: true
require 'jwt'
require 'webmachine'
require 'ostruct'
require './app/resources/render'

# Resource for creating a user.
class SignupResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(POST)
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def post_is_create?
    true
  end

  def create_path
    "/users/#{user.username}"
  end

  private

  def from_json
    response.body = render(template: 'user', locals: { user: user, jwt: jwt })
  end

  def user
    @user ||= OpenStruct.new(username: 'tom')
  end

  def jwt
    @jwt ||= JWT.encode({ username: user.username }, 'secret', 'HS256')
  end
end
