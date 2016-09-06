class AddCreditCardTable < ActiveRecord::Migration
  def change
    create_table :creditcards do |t|
      t.string :credit_card_owner
      t.integer :credit_card_number
      t.date :an_expiration_date
      t.timestamps null: false
    end
  end
end
