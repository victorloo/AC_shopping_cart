class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.sn = rand(100..999) + @order.id.to_i + Time.now.to_i
    @order.add_order_items(current_cart)
    @order.amount = current_cart.subtotal

    if @order.save
      current_cart.destroy
      UserMailer.notify_order_create(@order).deliver_now!
      redirect_to orders_path, notice: "now order created"
    else
      @items = current_cart.cart_items
      render "carts/show"
    end

  end

  def show
    @order = Order.find(params[:id])
  end
    
  private

  def order_params
    params.require(:order).permit(:name, :phone, :payment_status, :address)
  end
  
end