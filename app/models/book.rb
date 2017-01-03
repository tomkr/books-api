# Representation of a Book object backed by the database.
class Book < ActiveRecord::Base
  validates :title, presence: true
end
