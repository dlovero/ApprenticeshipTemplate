class BookSerializer < ActiveModel::Serializer
  attributes :isbn,:title,:price
end
