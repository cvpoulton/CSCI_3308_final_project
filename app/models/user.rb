class User < ActiveRecord::Base
  attr_accessible :first_name, :interests, :last_name, :password, :quotes, :walldate
end
