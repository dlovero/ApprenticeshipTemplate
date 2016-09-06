class AddingBooksCartsNowHasAmount < ActiveRecord::Migration

  def change
    add_column(:books_carts,:amount,:integer)
  end

end
