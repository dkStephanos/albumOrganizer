class AddRequestedUserIdToBorrowRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :borrow_requests, :requested_user_id, :integer
  end
end
