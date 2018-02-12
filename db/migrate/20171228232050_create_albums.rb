class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :release_date
      t.integer :artist_id

      t.timestamps
    end
  end
end
