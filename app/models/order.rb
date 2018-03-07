class Order < ApplicationRecord
  validates_presence_of :name, :address, :phone, :payment_status, :shipping_status

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  belongs_to :user

#  def add_order_item(item)
#    order_item = order_items.build( product_id: item.product_id, price: item.product.price, quantity: item.quantity )
#    order_item.save!
#    self.order_items # 確保最後回傳的是存在的商品
#  end

  # 已經在 order_item.rb 新增order_total
#  def total_amount
    # .map 回傳 array
#    order_items.map do |item| # 用 map 可以直接回傳一個 array
#      item.order_total # 來自 order_total_item.rb 的方法
#    end.sum # 方法可以接在end後面，等同直接使用方法在 return 值
#  end

end