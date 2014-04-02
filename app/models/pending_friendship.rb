class PendingFriendship < ActiveRecord::Base
  attr_accessible :from_user, :user_id
  belongs_to :user
end
