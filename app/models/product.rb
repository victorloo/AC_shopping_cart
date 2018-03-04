class Product < ApplicationRecord
  validates_presence_of :name, :description, :price
  # 驗證欄位，確保指定的屬性有填寫

  mount_uploader :image, PhotoUploader
  # carrierwave 的載具

  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  # 因為連結關聯表，因此會有另一張間接的表，要標示出來(用through)

  has_many :order_items
  has_many :orders, through: :order_items
end