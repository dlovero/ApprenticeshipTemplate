class MajorChangesToSale < ActiveRecord::Migration
  def change
    rename_column :sales,:credit_cards_id, :credit_card_id
    add_belongs_to :items,:sale
    add_column :sales,:total_price,:float
  end
end
