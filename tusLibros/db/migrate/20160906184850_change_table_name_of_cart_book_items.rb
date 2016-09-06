class ChangeTableNameOfCartBookItems < ActiveRecord::Migration
  def change
    rename_table(:car_books_items_tables,:cart_book_items_tables)
  end
end
