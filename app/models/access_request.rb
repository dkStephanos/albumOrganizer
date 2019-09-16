class AccessRequest < ApplicationRecord
  belongs_to :requester
  belongs_to :requested

	has_one :requester, :class_name => "User"
	has_one :requested, :class_name => "User"
end
