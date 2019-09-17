class AddRecentlyReturnedToArtist < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :recentlyReturned, :boolean
  end
end
