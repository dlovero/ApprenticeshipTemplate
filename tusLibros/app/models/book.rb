class Book < ActiveRecord::Base
  has_many :carts, through: :items
end
