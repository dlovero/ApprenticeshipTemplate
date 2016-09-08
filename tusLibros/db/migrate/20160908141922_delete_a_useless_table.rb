class DeleteAUselessTable < ActiveRecord::Migration
  def change
    drop_table  :table_for_sales
  end
end
