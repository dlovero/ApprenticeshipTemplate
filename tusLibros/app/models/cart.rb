class Cart < ActiveRecord::Base
  has_many :items
  has_many :books, through: :items
  belongs_to :sale
  belongs_to :cart

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
  end

  def occurrences_of(a_book_id)
    item = items.find_by(book_id: a_book_id)
    item ? item.amount_of_books : 0
  end

  def total_price
    items.map { |an_item| self.occurrences_of(an_item.book_id) * Book.find_by(id:an_item.book_id).price }.inject(0,:+)
  end


end
