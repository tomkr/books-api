class AddSlugs < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :slug, :string, null: false
    add_column :books, :slug, :string, null: false
    add_column :series, :slug, :string, null: false
  end
end
