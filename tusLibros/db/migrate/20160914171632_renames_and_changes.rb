class RenamesAndChanges < ActiveRecord::Migration
  def change
    rename_column :sales,:cart_id,:items
    add_reference :cart_sessions,:user
    remove_column :carts,:user_id
    add_reference :items,:sale
  end

end
