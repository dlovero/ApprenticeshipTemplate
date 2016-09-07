class Book < ActiveRecord::Base
  has_many :items
  has_many :carts, through: :cart_book_items



end
