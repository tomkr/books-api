# frozen_string_literal: true
class BooksRequireAuthor < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :author_id, :integer, null: false
  end
end
