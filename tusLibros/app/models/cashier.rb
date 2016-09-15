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
    @merchant_processor.charge(a_credit_card, a_cart_session.total_price)
    Sale.register_new_sale!(a_credit_card, a_cart_session)
    a_cart_session.end
  end
end