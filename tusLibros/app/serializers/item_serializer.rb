class ItemSerializer < ActiveModel::Serializer
  attributes :title, :isbn, :amount_of_books, :price
end
