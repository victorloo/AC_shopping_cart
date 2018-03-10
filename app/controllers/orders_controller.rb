class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    # 手動確認是否登入
    if current_user.nil?
      # 如果 session 有檔案，便可以在之後取回
      session[:new_order_data] = params[:order]
      # 回到 devise 登入頁面
      redirect_to new_user_session_path
    else
      @order = current_user.orders.new(order_params)
      @order.sn = rand(100..999) + @order.id.to_i + Time.now.to_i
      @order.add_order_items(current_cart)
      @order.amount = current_cart.subtotal

      if @order.save
        current_cart.destroy
        # 訂單建立後，相關檔案要清除
        session.delete(:new_order_data)
        UserMailer.notify_order_create(@order).deliver_now!
        redirect_to orders_path, notice: "now order created"
      else
        @items = current_cart.cart_items
        render "carts/show"
      end
    end

  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.shipping_status == "not_shipped"
      @order.shipping_status = "cancelled"
      @order.save
      redirect_to orders_path, alert: "order ##{@order.sn} cancelled"
    end
  end
  
  def checkout_spgateway
    @order = current_user.orders.find(params[:id])
    if @order.payment_status != "not_paid"
      flash[:alert] = "Order has been paid."
      redirect_to orders_path
    else
      @payment = Payment.create!(
        sn: Time.now.to_i,
        order_id: @order.id,
        amount: @order.amount
      )
      render layout: false
    end
  end
    
  private

  def order_params
    params.require(:order).permit(:name, :phone, :payment_status, :address)
  end
  
end