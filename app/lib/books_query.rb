# frozen_string_literal: true

# Wrapper around a query for books in the BooksResource.
class BooksQuery
  attr_reader :author, :serie

  def initialize(author: nil, serie: nil)
    @author = Author.find_by(slug: author)
    @serie = Serie.find_by(slug: serie)
  end

  def execute
    Book.where(query)
  end

  private

  def query
    return @query if @query
    @query = {}
    @query[:author] = author if author
    @query[:serie] = serie if serie
    @query
  end
end
