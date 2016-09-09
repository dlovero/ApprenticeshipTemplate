class User < ActiveRecord::Base
  has_many :carts
  has_many :credit_cards

  validates :user_name, presence: true
  validates :password, length: {minimum: 6, message: 'Password is too short'}

end
