class Sale < ActiveRecord::Base
  has_many :items
  belongs_to :credit_card
  belongs_to :user

  def find_all_sales_formated(list)
    items.each do |item|
      list.push({"ISBN" => item.book.isbn, "AMOUNT" => item.amount_of_books})
    end
  end

  def self.register_new_sale!(a_credit_card,a_cart_session)
   a_sale = Sale.create!(credit_card: a_credit_card, total_price: a_cart_session.total_price, user: a_cart_session.user)
   a_sale.items+=a_cart_session.cart.items
   a_sale.save!
  end
end

