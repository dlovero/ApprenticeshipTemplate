class AddColumnToTable < ActiveRecord::Migration
  def change
    add_column :boards, :turn, :integer
    add_column :boards, :winner, :string
  end
end
