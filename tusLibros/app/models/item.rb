class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book

  validates :amount_of_books, numericality: {greater_than: 0}

  def isbn
    book.isbn
  end

end
