class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  # 因為連結關聯表，因此會有另一張間接的表，要標示出來(用through)

  def add_cart_item(product)
    # 從1→n，建立關聯
    existing_item = self.cart_items.find_by( product_id: product )
    # 存在的商品，來自於自己→連結關聯表→搜尋(用sql語法撈資料， product 是參數)
    if existing_item # 如果存在，則數量增加
      existing_item.quantity += 1
      existing_item.save!
    else #如果不存在，則建立
      # 從0→1，建立關聯
      cart_item = cart_items.build( product_id: product.id ) # 類似.new，慣例上用在關聯物件的建立，產生一個實例，尚未存入資料庫，需要.save
      cart_item.save!
    end
    self.cart_items # 確保最後回傳的是存在的商品
  end

  # 已經在 cart_item.rb 新增item_total
  def subtotal
    # .map 回傳 array
    cart_items.map do |item| # 用 map 可以直接回傳一個 array
      item.item_total # 來自 cart_item.rb 的方法
    end.sum # 方法可以接在end後面，等同直接使用方法在 return 值
  end

  def find_item_by(product) # ajax 會用到，我猜是方便撈資料才這樣寫
    self.cart_items.where(product_id: product).first
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