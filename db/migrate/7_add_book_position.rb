# frozen_string_literal: true
class AddBookPosition < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :position, :integer
  end
end
