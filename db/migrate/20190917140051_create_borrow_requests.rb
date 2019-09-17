class CreateBorrowRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :borrow_requests do |t|
      t.references :user, foreign_key: true
      t.references :artist, foreign_key: true
      t.boolean :isAccepted

      t.timestamps
    end
  end
end
