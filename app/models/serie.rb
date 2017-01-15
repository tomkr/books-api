require './app/sluggify'

# Representation of a Serie of Books backed by the database.
class Serie < ActiveRecord::Base
  include Sluggify
  has_many :books
  validates :title, :slug, presence: true, uniqueness: true

  def initialize(attributes)
    slug = sluggify(attributes['title'])
    super(attributes.merge('slug' => slug))
  end
end
