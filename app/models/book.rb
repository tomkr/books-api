# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, presence: true
end
