class CartSessionSerializer < ActiveModel::Serializer
  attributes :cart_id
  has_many :items
end
