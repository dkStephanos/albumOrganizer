class RemoveIsFavoriteFromSongs < ActiveRecord::Migration[5.1]
  def change
    remove_column :songs, :is_favorite, :boolean
  end
end
