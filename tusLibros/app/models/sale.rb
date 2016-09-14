class Sale < ActiveRecord::Base
  has_many :items
  belongs_to :credit_card
  belongs_to :user

  def find_all_sales_formated(list)
    items.each do |item|
      list.push({"ISBN"=>item.book.isbn,"AMOUNT" => item.amount_of_books})
     end
  end
end

