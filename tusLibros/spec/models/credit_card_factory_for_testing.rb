module CreditCardFactoryForTesting
  def a_valid_credit_card_number
    '4712371231231233'
  end

  def a_valid_credit_card_owner
    'Ayelen Mac Garcia'
  end

  def a_valid_expiration_date
    MonthYear.new(12, 3010)
  end

  def a_valid_credit_card
    CreditCard.create!(credit_card_owner: a_valid_credit_card_owner,credit_card_number: a_valid_credit_card_number,expiration_date: a_valid_expiration_date)
  end
end