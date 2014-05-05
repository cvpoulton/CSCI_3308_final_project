class User < ActiveRecord::Base
  attr_accessible :username, :first_name, :interests, :last_name, :password, :password_confirmation, :quotes, :walldate
  has_many :posts
  has_many :friendships
  has_many :pending_friendships

  validates :username, uniqueness: {message: "already taken!"}, presence: true, format: {with: /\A[a-zA-Z0-9]+\Z/, message: "must be alphanumeric and no spaces!"}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: true
  validates :walldate, presence: true
end
