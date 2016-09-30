class BoardSerializer < ActiveModel::Serializer
  attributes :boardPositions, :id, :turn, :winner
end
