class CartsController < ApplicationController

  def show
    @cart = current_cart # 對應到 application_controller的方法
    @items = current_cart.cart_items # 使用關聯表來連結
  end
  
end