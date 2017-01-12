require './app/sluggify'

# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  include Sluggify
  belongs_to :author
  belongs_to :serie
  validates :author_id, presence: true
  validates :title, :slug, presence: true, uniqueness: true

  def update(title:, author:)
    slug = sluggify(title)
    super(title: title, slug: slug, author: author)
  end
end
