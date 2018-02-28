class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  before_action :set_product, only: [:edit, :update, :show, :destory]
  def index
    @products = Product.page(params[:page]).per(20)
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
  
  def destroy
    if @product.destroy
      flash[:alert] = 'Product was successfully deleted.'
      redirect_to admin_products_path
    else
      flash[:notice] = 'Something went wrong'
      redirect_to admin_products_path
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