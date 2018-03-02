class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  # 計算 cart 總價錢
  def item_total
    self.quantity * self.product.price
  end
end