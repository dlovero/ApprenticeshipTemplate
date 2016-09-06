class ChangeColumnNameCartBookItemTable < ActiveRecord::Migration
  def change
    rename_column(:cart_book_items,:an_amount_of_book,:amount_of_books)
  end
end
