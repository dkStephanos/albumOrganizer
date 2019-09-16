class AddAttachmentAlbumCoverToAlbums < ActiveRecord::Migration[5.1]
  def self.up
    change_table :albums do |t|
      t.attachment :album_cover
    end
  end

  def self.down
    remove_attachment :albums, :album_cover
  end
end
