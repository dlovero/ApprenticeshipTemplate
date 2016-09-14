class Sale < ActiveRecord::Base
  has_many :items
  belongs_to :credit_card
  belongs_to :user

  def find_all_sales_formated(hash)
    items.each do |item|
      hash[item.book.isbn] = item.amount_of_books
     end
  end
end

