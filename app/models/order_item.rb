class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  #def order_total
  #  self.quantity * self.price
  #end
end