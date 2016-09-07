class ChangeTheTypeOfCreditCardNumber < ActiveRecord::Migration
  def change
    change_column(:credit_cards,:credit_card_number,:string)
  end
end
