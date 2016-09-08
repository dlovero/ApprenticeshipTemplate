class Sale < ActiveRecord::Base
  has_one :cart
  has_one :credit_card
  belongs_to :user

  def items
    cart.items

  end

end
