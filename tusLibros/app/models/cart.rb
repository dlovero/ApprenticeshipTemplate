class Cart < ActiveRecord::Base
  has_many :items
  has_many :books, through: :items
  belongs_to :user

  def empty?
    books.empty?
  end

  def total_amount_of_books
    items.map { |item| item.amount_of_books }.reduce(0, :+)
  end

  def add(a_book, an_amount)
    item = items.find_or_initialize_by(book: a_book) do |item|
      item.amount_of_books = 0
    end
    item.amount_of_books += an_amount
    item.save!
  end

  def list
    items.collect do |item|
      {"ISBN" => item.book.isbn, "AMOUNT" => item.amount_of_books}
    end
  end

  def occurrences_of(a_book)
    item = items.find_by(book: a_book)
    item ? item.amount_of_books : 0
  end

  def total_price
    items.map { |an_item| self.occurrences_of(an_item.book) * an_item.book.price }.inject(0, :+)
  end


end
