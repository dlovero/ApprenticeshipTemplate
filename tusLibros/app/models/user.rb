class User < ActiveRecord::Base
  has_many :carts
  has_many :credit_cards

  validates :user_name, presence: true
  validates :password, length: {minimum: 6, message: 'Password is too short'}


  def self.log_in!(hash)
    user = User.find_by(id: hash[:id].to_i, password: hash[:password])
    assert_valid_user(user)
    user
  end


  def self.assert_valid_user(user)
    raise UnauthorizedException, "Couldn't find User" if user.nil?
  end

end
