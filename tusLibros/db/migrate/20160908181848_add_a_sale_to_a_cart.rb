class AddASaleToACart < ActiveRecord::Migration
  def change
    add_belongs_to :carts,:sale
  end
end
