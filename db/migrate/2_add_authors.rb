class AddAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.timestamps
    end

    add_reference :books, :author, index: true, foreign_key: true
  end
end
