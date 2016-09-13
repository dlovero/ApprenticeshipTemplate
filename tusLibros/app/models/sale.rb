class Sale < ActiveRecord::Base
  has_one :cart
  has_one :credit_card
  belongs_to :user

  def items
    Cart.find_by(id:cart_id).items
  end

  def find_all_sales_for(an_user_id)
    Cart.find_by(user_id: an_user_id).items.collect do |item|
      {Book.find_by(id: item.book_id).isbn => item.amount_of_books}
    end
  end
end

