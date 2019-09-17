class AddLoanedUserIdToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :loaned_user_id, :integer
  end
end
