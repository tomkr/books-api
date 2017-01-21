# frozen_string_literal: true
# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :serie
  validates :author_id, presence: true
  validates :title, :slug, presence: true, uniqueness: true

  def prev
    return if serie.blank? || position.blank? || position <= 1
    serie.books.find_by(position: position - 1)
  end

  def next
    return if serie.blank? || position.blank? || position >= serie.books.count
    serie.books.find_by(position: position + 1)
  end
end
