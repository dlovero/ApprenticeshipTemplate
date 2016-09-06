class AmountInBooksCartsCannotBeNull < ActiveRecord::Migration

  def change
    change_column_null :books_carts,:amount, false
  end

end
