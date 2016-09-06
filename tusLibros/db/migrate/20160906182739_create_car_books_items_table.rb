class CreateCarBooksItemsTable < ActiveRecord::Migration
  def change
    create_table :car_books_items_tables do |t|
      t.belongs_to :cart
      t.belongs_to :book
      t.integer :an_amount_of_book
    end
  end
end
