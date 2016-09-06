class ChangeTableNameOfCartBookItemsx2 < ActiveRecord::Migration
  def change
    drop_table(:cart_book_items)
    rename_table(:cart_book_items_tables,:cart_book_items)
  end
end
