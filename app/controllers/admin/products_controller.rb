class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  before_action :set_product, only: [:edit, :update, :show, :destory]
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
  end

  def edit
  end
  
  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product was successfully updated"
      redirect_to admin_product_path(@product)
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end
  

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end