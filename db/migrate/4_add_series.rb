class AddSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.string :title
      t.timestamps
    end

    add_reference :books, :serie, index: true, foreign_key: true
    add_column :books, :serie_position, :integer
  end
end
