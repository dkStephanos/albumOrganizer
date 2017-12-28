class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :length
      t.boolean :is_favorite
      t.integer :album_id

      t.timestamps
    end
  end
end
