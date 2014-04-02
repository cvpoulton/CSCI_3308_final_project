class PendingFriendship < ActiveRecord::Base
  attr_accessible :from_user, :user_id
end
