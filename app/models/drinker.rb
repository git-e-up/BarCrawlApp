class Drinker < ActiveRecord::Base

  has_secure_password

  has_many(:chats)

end
