class Friendship < ActiveRecord::Base
  attr_accessible :other_user, :user_id
end
