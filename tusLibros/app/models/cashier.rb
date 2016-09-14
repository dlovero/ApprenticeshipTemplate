class Cashier

  def initialize(a_merchant_processor)
    @merchant_processor = a_merchant_processor
  end

  def assert_not_an_empty_cart(a_cart)
    raise self.class.error_message_checking_out_an_empty_cart if a_cart.empty?
  end

  def self.error_message_checking_out_an_empty_cart
    'Cannot checkout an empty cart'
  end

  def checkout(a_cart_session, a_credit_card)
    assert_not_an_empty_cart(a_cart_session)
    total_price = a_cart_session.total_price
    @merchant_processor.charge(a_credit_card, total_price)
    a_sale = Sale.create!(credit_card: a_credit_card, total_price: total_price, user: a_cart_session.user)
    a_sale.items+=a_cart_session.cart.items
    a_sale.save!
    a_cart_session.cart.destroy
    a_cart_session.destroy
  end
end