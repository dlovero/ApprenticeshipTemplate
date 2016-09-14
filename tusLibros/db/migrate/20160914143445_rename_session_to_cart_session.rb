class RenameSessionToCartSession < ActiveRecord::Migration
  def change
    rename_table :sessions, :cart_sessions
  end
end
