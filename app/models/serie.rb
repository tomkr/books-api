# frozen_string_literal: true
# Representation of a Serie of Books backed by the database.
class Serie < ActiveRecord::Base
  has_many :books
  validates :title, :slug, presence: true, uniqueness: true
end
