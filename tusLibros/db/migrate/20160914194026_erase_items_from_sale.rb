class EraseItemsFromSale < ActiveRecord::Migration
  def change
    remove_column :sales,:item
  end
end
