class DropOldBooksCart < ActiveRecord::Migration
  def change
    drop_join_table(:books,:carts)
  end
end
