class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :remember_me
  has_secure_password
end
