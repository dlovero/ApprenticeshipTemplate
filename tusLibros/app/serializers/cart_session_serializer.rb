class CartSessionSerializer < ActiveModel::Serializer
  attributes :cart_id, :user_id
  has_many :items
end
