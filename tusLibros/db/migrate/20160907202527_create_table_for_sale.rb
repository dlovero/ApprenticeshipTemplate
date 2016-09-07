class CreateTableForSale < ActiveRecord::Migration
  def change
    create_table :table_for_sales do |t|
      t.float :total_price
    end
  end
end
