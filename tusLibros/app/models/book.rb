class Book < ActiveRecord::Base
  has_many :cart_book_items
  has_many :carts, through: :cart_book_items



end
