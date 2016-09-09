class CreateColumns < ActiveRecord::Migration
  def change
    add_belongs_to :credit_cards, :user
    change_column_null :credit_cards,:user_id,false
  end
end
