class CreateAccessRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :access_requests do |t|
      t.references :requester, foreign_key: true
      t.references :requested, foreign_key: true
      t.boolean :isApproved

      t.timestamps
    end
  end
end
