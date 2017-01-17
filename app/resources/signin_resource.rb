# frozen_string_literal: true
require 'webmachine'
require './app/resources/render'
require './app/models/user'

# Resource for signing a user in.
class SigninResource < Webmachine::Resource
  include Render

  def allowed_methods
    %w(POST)
  end

  def process_post
    return 400 if user.blank?
    response.body = render(template: 'user', locals: { user: user })
    true
  end

  private

  def user
    @user ||= User.find_by(params)
  end

  def params
    @params ||= JSON.parse(request.body.to_s).slice('username', 'password')
  end
end
