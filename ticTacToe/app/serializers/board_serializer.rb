class BoardSerializer < ActiveModel::Serializer
  attributes :id, :turn, :winner
  has_many :squares
end
