class ProductsController < ApplicationController

  def index
    #session[:abc] = '123'
    @products = Product.page(params[:page]).per(9)
  end
    
  def show
    @product = Product.find(params[:id])
  end
  
  def add_to_cart
    @product = Product.find(params[:id])
    current_cart.add_cart_item(@product) # 加 product item

    #redirect_back(fallback_location: root_path)
  end

  # 名稱不用 delete ，是因為 delete 專門給 destroy 使用
  def remove_from_cart
    @product = Product.find(params[:id])
    # 懶人刪除法，全部刪除
    cart_item = current_cart.cart_items.find_by(product_id: @product)
    cart_item.destroy

    #redirect_back(fallback_location: root_path)
  end

  def adjust_item
    @product = Product.find(params[:id])
    cart_item = current_cart.cart_items.find_by(product_id: @product)

    # 正確的數量+-
    if params[:type] == "add"
      cart_item.quantity += 1
    elsif params[:type] == "substract"
      cart_item.quantity -= 1
    end

    if cart_item.quantity == 0
      cart_item.destroy
    else
      cart_item.save
    end
    #redirect_back(fallback_location: root_path)
  end
end