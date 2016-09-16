class Sale < ActiveRecord::Base
  has_many :items
  belongs_to :credit_card
  belongs_to :user

  def self.find_all_sales_formated(user)
    all_sales=Sale.where(user: user)
    all_sales.reduce([]) do |all_items, sale|
      all_items+=sale.items
    end
  end

  def self.register_new_sale!(a_credit_card, a_cart_session)
    a_sale = Sale.create!(credit_card: a_credit_card, total_price: a_cart_session.total_price, user: a_cart_session.user)
    a_sale.items+=a_cart_session.cart.items
    a_sale.save!
    a_sale.id
  end

  def transaction_id
    id
  end

end

