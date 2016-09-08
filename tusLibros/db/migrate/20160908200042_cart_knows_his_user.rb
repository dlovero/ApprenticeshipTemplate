class CartKnowsHisUser < ActiveRecord::Migration
  def change
    add_belongs_to :carts,:user
    add_belongs_to :sales,:user
  end
end
