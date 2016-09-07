class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :book
  belongs_to :sale
end
