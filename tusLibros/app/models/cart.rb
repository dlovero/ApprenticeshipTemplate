class Cart < ActiveRecord::Base
  has_many :items
  has_many :books, through: :items
  belongs_to :sale
  belongs_to :cart

  def empty?
    books.empty?
  end


  def amount_of_books
    items.map { |item| item.amount_of_books }.reduce(0, :+)
  end

  def add(a_book, an_amount)
    item = items.detect(proc { items.create!({book: a_book, amount_of_books: 0}) }) do
    |item|
      item.book == a_book
    end

    item.amount_of_books += an_amount
    item.save!
  end

  def occurrences_of(a_book)
    item = items.detect() { |item| item.book == a_book }
    item ? item.amount_of_books : 0
  end

  def total_price
    items.map { |an_item| self.occurrences_of(an_item.book) * an_item.book.price }.inject(0,:+)
  end


end
