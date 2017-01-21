# frozen_string_literal: true
require './app/resources/base_resource'
require './app/models/serie'
require './app/models/book'

# A webmachine resource for the collection of books in a serie.
class SerieBooksResource < BaseResource
  def allowed_methods
    %w(GET)
  end

  def content_types_provided
    [['application/hal+json', :to_json]]
  end

  private

  def to_json
    render(template: 'books',
           locals: {
             books: books,
             self_link: "/series/#{serie.slug}/books"
           })
  end

  def books
    @books ||= Book.where(serie: serie)
  end

  def serie
    @serie ||= Serie.find_by(slug: slug)
  end

  def slug
    request.path_info[:id]
  end
end
