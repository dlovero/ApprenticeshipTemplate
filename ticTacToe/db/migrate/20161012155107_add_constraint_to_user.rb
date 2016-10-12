class AddConstraintToUser < ActiveRecord::Migration
  def change
    add_index :users, :username, unique: true
    add_belongs_to :users, :username, :player_x
    add_belongs_to :users, :username, :player_o
  end
end

