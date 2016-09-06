class CreateCartBookItems < ActiveRecord::Migration
  def change
    create_table :cart_book_items do |t|

      t.timestamps null: false
    end
  end
end
