class AddSomeColumnsToSale < ActiveRecord::Migration
  def change
    add_belongs_to :sales, :credit_cards
  end
end
