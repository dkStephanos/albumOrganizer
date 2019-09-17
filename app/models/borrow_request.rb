class BorrowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :artist
  belongs_to :requested_user, :class_name => "User"
end
