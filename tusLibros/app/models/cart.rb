class Cart < ActiveRecord::Base
  has_many :cart_book_items
  has_many :books, through: :cart_book_items

  def empty?
    books.empty?
  end


  def amount_of_books
    cart_book_items.all.select do
      |item| item.cart_id == id
    end.inject 0 do
      | acum, item | acum+item.amount_of_books
    end
  end

  def add(a_book,an_amount)
    if(cart_book_items.find_by(id,a_book.id).nil?)
    cart_book_items.create!({book_id:a_book.id, cart_id:id, amount_of_books: an_amount})
    else
    cart_book_items.find_by(id,a_book.id).update_attribute(:amount_of_books, (cart_book_items.find_by(id,a_book.id).amount_of_books)+an_amount)
    end
  end

  def occurrences_of(a_book)
    cart_book_items.find_by(id,a_book.id).amount_of_books
  end





end
