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

  def checkout(a_cart, a_credit_card)
    assert_not_an_empty_cart(a_cart)
    total_price = a_cart.total_price
    @merchant_processor.charge(a_credit_card, total_price)
    a_sale=Sale.create(credit_card_id: a_credit_card.id, total_price: total_price, cart: a_cart, user_id: a_cart.user_id)
    a_cart.sale_id=a_sale.id
  end
end