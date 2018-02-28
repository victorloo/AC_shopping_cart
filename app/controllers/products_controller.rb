class ProductsController < ApplicationController

  def index
    @products = Product.page(params[:page]).per(21)
  end
    
  def show
    @product = Product.find(params[:id])
  end
  
end