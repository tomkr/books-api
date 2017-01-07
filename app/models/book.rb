# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, :author_id, presence: true
end
