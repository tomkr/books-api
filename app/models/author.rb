# frozen_string_literal: true
# Representation of an Author backed by the database.
class Author < ActiveRecord::Base
  validates :name, :slug, presence: true, uniqueness: true
end
