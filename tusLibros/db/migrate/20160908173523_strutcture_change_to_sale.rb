class StrutctureChangeToSale < ActiveRecord::Migration
  def change
    add_belongs_to :sales, :cart
  end
end
