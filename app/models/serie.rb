# Representation of a Serie of Books backed by the database.
class Serie < ActiveRecord::Base
  has_many :books
  validates :title, presence: true
end
