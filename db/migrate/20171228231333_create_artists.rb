class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :bio
      t.integer :user_id

      t.timestamps
    end
  end
end
