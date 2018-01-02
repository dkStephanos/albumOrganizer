class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :length
      t.integer :album_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
