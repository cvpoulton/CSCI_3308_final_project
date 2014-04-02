class Post < ActiveRecord::Base
  attr_accessible :from_user, :message, :time, :user_id
  belongs_to :user
end
