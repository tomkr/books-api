# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :serie
  validates :title, :author_id, presence: true
end
