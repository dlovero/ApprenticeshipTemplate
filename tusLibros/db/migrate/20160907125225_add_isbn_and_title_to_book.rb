class AddIsbnAndTitleToBook < ActiveRecord::Migration
  def change
    add_column(:books, :title, :string)
    add_column(:books, :isbn, :string)
  end
end
