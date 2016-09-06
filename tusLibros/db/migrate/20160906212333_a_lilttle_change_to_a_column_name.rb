class ALilttleChangeToAColumnName < ActiveRecord::Migration
  def change
    drop_table(:credit_cards)
    rename_table(:creditcards,:credit_cards)
    rename_column(:credit_cards,:an_expiration_date,:expiration_date)
  end
end
