class User < ActiveRecord::Base
  has_many :carts

  validates :user_name, presence: true
  validates :password, length: {minimum: 6, message: 'Password is too short'}

end
