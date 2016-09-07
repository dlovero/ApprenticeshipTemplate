class Cashier
  def initialize(a_merchant_processor#, a_sales_book)
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
    @merchant_processor.bill(a_credit_card, total_price)
#todo FIX THIS    @sales_book.push(Sale.create(a_credit_card, a_cart.list_cart, total_price))
  end
end