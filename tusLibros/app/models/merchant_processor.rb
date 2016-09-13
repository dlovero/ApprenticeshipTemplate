class MerchantProcessor
  def charge(a_credit_card, a_price)
    @credit_card = a_credit_card
    @price_charged = a_price
  end
end