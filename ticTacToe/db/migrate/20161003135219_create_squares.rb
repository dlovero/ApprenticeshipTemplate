class CreateSquares < ActiveRecord::Migration
  def change
    create_table :squares do |t|
      t.integer :x
      t.integer :y
      t.string :mark
      t.belongs_to :board
    end
  end
end
