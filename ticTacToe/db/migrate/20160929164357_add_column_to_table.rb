class AddColumnToTable < ActiveRecord::Migration
  def change
    add_column :boards, :turn, :integer
    add_column :boards, :winner, :string
    add_column :boards, :value0, :string
    add_column :boards, :value1, :string
    add_column :boards, :value2, :string
    add_column :boards, :value3, :string
    add_column :boards, :value4, :string
    add_column :boards, :value5, :string
    add_column :boards, :value6, :string
    add_column :boards, :value7, :string
    add_column :boards, :value8, :string
  end
end
