class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.references :player_x
      t.references :player_o
    end

  end
end
