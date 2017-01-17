# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/user'

# Resource for creating a user.
class SignupResource < BaseResource
  def allowed_methods
    %w(OPTIONS POST)
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
    user.save
    response.body = render(template: 'user', locals: { user: user })
  end

  def user
    @user ||= User.new(username: 'tom', password: 'password')
  end
end
