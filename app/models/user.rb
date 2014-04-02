class User < ActiveRecord::Base
  attr_accessible :first_name, :interests, :last_name, :password, :quotes, :walldate
  has_many :posts
  has_many :friendships
  has_many :pending_friendships
end
