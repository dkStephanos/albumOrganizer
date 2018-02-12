class CreateUserFavoriteSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_favorite_songs do |t|
      t.integer :user_id
      t.integer :song_id

      t.timestamps
    end
  end
end
