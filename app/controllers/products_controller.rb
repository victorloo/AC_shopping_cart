class ProductsController < ApplicationController

  def index
    session[:abc] = '123'
    @products = Product.page(params[:page]).per(8)
  end
    
  def show
    @product = Product.find(params[:id])
  end
  
  def add_to_cart
    @product = Product.find(params[:id])
    current_cart.add_cart_item(@product) # 加 product item

    redirect_to root_path
    # 也可以這樣寫︰redirect_back(fallback_location: root_path)
  end

  # 名稱不用 delete ，是因為 delete 專門給 destroy 使用
  def remove_from_cart
    product = Product.find(params[:id])
    # 懶人刪除法，全部刪除
    cart_item = current_cart.cart_items.find_by(product_id: product)
    cart_item.destroy

    # 正確的數量+-要自己想
    redirect_back(fallback_location: root_path)
  end

end