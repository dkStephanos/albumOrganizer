class AddIsFavoriteToSongs < ActiveRecord::Migration[5.1]
  def change
    add_column :songs, :is_favorite, :boolean, default: 0
  end
end
