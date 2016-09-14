class Cart < ActiveRecord::Base
  has_many :items
  has_many :books, through: :items
  belongs_to :sale
  belongs_to :user

  def empty?
    books.empty?
  end

  def total_amount_of_books
    items.map { |item| item.amount_of_books }.reduce(0, :+)
  end

  def add(a_book, an_amount)
    item=items.find_or_create_by(book_id: a_book.id) do |item|
      item.amount_of_books = 0
    end
    item.amount_of_books += an_amount
    item.save!
    true
  end

  def list
    items.collect do |item|
      cache=Book.find_by(item.book_id)
      {cache.isbn => item.amount_of_books}
    end

  end

  def occurrences_of(a_book_id)
    item = items.find_by(book_id: a_book_id)
    item ? item.amount_of_books : 0
  end

  def total_price
    items.map { |an_item| self.occurrences_of(an_item.book_id) * Book.find_by(id:an_item.book_id).price }.inject(0,:+)
  end

end
