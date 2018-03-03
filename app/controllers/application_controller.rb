class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception 
  # 啟動 CSRF 安全性功能，所有非GET的HTTP request都必須帶有一個Token參數才能存取，
  # Rails會自動在所有表單中幫你插入Token參數，預設的Layout中也有一行<%= csrf_meta_tag %>標籤
  # 可以讓JavaScript讀取到這個Token。

  # 當需要開放API給非瀏覽器客戶端時，例如手機端或第三方應用的回呼(webhook)，這時候我們會需要關閉這個功能

  # private 可以變成 global，這樣view上就可以用 current_cart → 自製的helper
  helper_method :current_cart 

  private
  
  def authenticate_admin!  # 驗證是否是管理員
    unless current_user.admin?
      flash[:alert] = "Not Allow!"
      redirect_to root_path
    end
  end

  # 未來需要在 controller 跟 view 使用，而且這是全部網頁都會用到，所以放在 application_controller
  def current_cart # 設計邏輯類似devise的 current_user
    @cart || set_cart
    # return @cart if @cart exist, or call set_cart
  end

  def set_cart # 製造 @cart
    
    # 假設session內已經有cart_id (登入才會有)
    if session[:cart_id] 
      @cart = Cart.find_by(id: session[:cart_id])
    end

    # 沒有cart_id，自己生成
    @cart ||= Cart.create

    # 跟rails說︰我想要存取這個cart的資訊
    session[:cart_id] = @cart.id

    # return @cart
    @cart
  end
end
