class AddingBooksCartsHasManyBelongsToMany < ActiveRecord::Migration


  def change
    create_join_table :books, :carts do |t|
      t.index :book_id
      t.index :cart_id
    end


  end
end
