# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/author'

# A webmachine resource for the collection of books.
class AuthorResource < BaseResource
  def allowed_methods
    %w(OPTIONS GET PUT DELETE)
  end

  def content_types_accepted
    [['application/json', :from_json]]
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  def delete_resource
    author.destroy
  end

  def resource_exists?
    author
  end

  private

  def from_json
    return invalid unless author.update(update_params)
    response.body = render(template: 'author', locals: { author: author })
  end

  def to_json
    render(template: 'author', locals: { author: author })
  end

  def author
    @author ||= Author.find_by(slug: slug)
  end

  def params
    @params ||= JSON.parse(request.body.to_s).slice('name')
  end

  def update_params
    @update_params ||= params.merge(slug: Sluggify.sluggify(params['name']))
  end

  def slug
    @slug ||= request.path_info[:slug]
  end

  def invalid
    response.body = author.errors.to_json
    400
  end
end
