class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_cart_item(product)
    # 從1→n，建立關聯
    existing_item = self.cart_items.find_by( product_id: product )
    if existing_item
      existing_item.quantity += 1
      existing_item.save!
    else
      # 從0→1，建立關聯
      cart_item = cart_items.build( product_id: product )
      cart_item.save!
    end
    self.cart_items
  end

  # 已經在 cart_item.rb 新增item_total
  def subtotal
    # .map 回傳 array
    cart_item.map do |item|  
      item.item_total
    end.sum # 方法可以接在end後面
  end

  def find_item_by(product)
    self.cart_items.where(product_id: product).first(quantity)
  end
  
  # 產生流水號
  # after_save :generate_uid or after_commit
  # before_save

  # 這樣的寫法無法面對同時間有大量訂單
  #def generete_uid
   # self.uid = id + product.create_time(時間跟數字)
   # self.uid = id {name timestamp } => hash commit
    #self.save
  #end
  #after_save :generate_uid
  
end