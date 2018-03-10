class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart # 對應到 application_controller的方法
    @items = current_cart.cart_items # 使用關聯表來連結

    if session[:new_order_data].present?
      @order = Order.new(session[:new_order_data])
    else
      @order = Order.new
    end
  end
  
end