# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :serie
  validates :author_id, presence: true
  validates :title, :slug, presence: true, uniqueness: true
end
