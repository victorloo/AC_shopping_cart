class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[product_params])
    if @product.save
      flash[:notice] = "Product successfully created"
      redirect_to admin_products_path
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end
  
  def show
    @product = Product.find(params[:id])
  end
  

  private
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not Allow!"
      redirect_to root_path
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end