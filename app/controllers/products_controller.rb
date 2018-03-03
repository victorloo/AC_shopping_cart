class ProductsController < ApplicationController

  def index
    #session[:abc] = '123'
    @products = Product.page(params[:page]).per(9) # 撈資料，首頁顯示的數量
  end
    
  def show
    @product = Product.find(params[:id]) # find(params[:id]) 可以撈到指定的資料
  end
  
  def add_to_cart
    @product = Product.find(params[:id]) # find(params[:id]) 可以撈到指定的資料
    current_cart.add_cart_item(@product) # current_cart 是自製的helper；add_cart_item() 來自models/cart.rb

    #redirect_back(fallback_location: root_path) #啟用ajax後，就不用轉向
  end

  # 名稱不用 delete ，是因為 delete 專門給 destroy 使用
  def remove_from_cart
    @product = Product.find(params[:id]) # find(params[:id]) 可以撈到指定的資料
    
    cart_item = current_cart.cart_items.find_by(product_id: @product) #撈指定的product，此時用關聯表連結；find_by回傳第一筆資料
    cart_item.destroy # 懶人刪除法，全部刪除

    #redirect_back(fallback_location: root_path) #啟用ajax後，就不用轉向
  end

  def adjust_item
    @product = Product.find(params[:id]) # find(params[:id]) 可以撈到指定的資料
    cart_item = current_cart.cart_items.find_by(product_id: @product) #撈指定的product，此時用關聯表連結；find_by回傳第一筆資料

    # 正確的數量+-
    if params[:type] == "add" # link_to那邊有設定 :symbol，好辨識該連結的特徵
      cart_item.quantity += 1
    elsif params[:type] == "substract" # link_to那邊有設定 :symbol，好辨識該連結的特徵
      cart_item.quantity -= 1
    end

    if cart_item.quantity == 0 #用數量來判定該product該不該移除
      cart_item.destroy
    else
      cart_item.save
    end
    #redirect_back(fallback_location: root_path) #啟用ajax後，就不用轉向
  end
end