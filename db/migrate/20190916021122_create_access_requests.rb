class CreateAccessRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :access_requests do |t|
      t.integer :requester_id
      t.integer :requested_id
      t.boolean :isApproved

      t.timestamps
    end
  end
end
