class RenameAmountColumnInBooksCarts < ActiveRecord::Migration

  def change
    rename_column(:books_carts,:amount,:amount_of_books)
  end
end
