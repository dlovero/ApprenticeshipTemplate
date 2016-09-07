class Cart < ActiveRecord::Base
  has_many :cart_book_items
  has_many :books, through: :cart_book_items

  def empty?
    books.empty?
  end


  def amount_of_books
    cart_book_items.map{ | item | item.amount_of_books }.reduce(0, :+)
  end

  def add(a_book, an_amount)
    item = cart_book_items.detect(proc { cart_book_items.create!({book: a_book, amount_of_books: 0 }) }) do
      | item | item.book == a_book
    end

    item.amount_of_books += an_amount
    item.save!
  end

  def occurrences_of(a_book)
    item = cart_book_items.detect(){ | item | item.book == a_book }
    item ? item.amount_of_books : 0
  end


end
