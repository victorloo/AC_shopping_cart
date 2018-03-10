class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.order(created_at: :desc)
  end

  def edit
    @order = Order.find(params[:id])
  end
  
end