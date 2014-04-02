class Friendship < ActiveRecord::Base
  attr_accessible :other_user, :user_id
  belongs_to :user
end
