class RenameCartBookItemToItem < ActiveRecord::Migration
  def change
    rename_table :cart_book_items, :items
  end
end
