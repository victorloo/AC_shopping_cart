class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  # 因為是關聯表，所以要告知連結的是哪兩張
  
  # 計算 cart 總價錢，因為 cart_item 已經不算是 product，獨立出計算方法較佳
  def item_total
    self.quantity * self.product.price
  end
end