class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # private 可以變成 global，這樣view上就可以用 current_cart
  helper_method :current_cart

  private

  # 未來需要在 controller 跟 view 使用，所以存取這個變數
  def current_cart
    @cart || set_cart
    # return @cart if @cart exist, or call set_cart
  end

  def set_cart
    
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
