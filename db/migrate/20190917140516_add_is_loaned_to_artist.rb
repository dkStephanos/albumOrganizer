class AddIsLoanedToArtist < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :isLoaned, :boolean
  end
end
