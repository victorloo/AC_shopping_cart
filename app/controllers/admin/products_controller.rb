class Admin::ProductsController < Admin::AdminController
  before_action :set_product, only: [:edit, :update, :show, :destory]
  def index
    @products = Product.page(params[:page]).per(10) # 撈資料，首頁顯示的數量
  end

  def new
    @product = Product.new # 物件的建立都要用 new
  end

  def create
    @product = Product.new(product_params) # 注意已經把「驗證」用private抽離
    if @product.save
      flash[:notice] = "Product successfully created"
      redirect_to admin_products_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end
  
  def update
    if @product.update_attributes(product_params) 
      # update_attributes 會接收傳進來的 Hash 並且 save，如果 object 無效或是被 validation 擋下的話會回傳 false
      flash[:notice] = "Product was successfully updated"
      redirect_to admin_product_path(@product)
    else
      flash[:alert] = "Something went wrong"
      render :edit
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
    @product = Product.find(params[:id]) # find(params[:id]) 可以撈到指定的資料
  end

  def product_params # rails 要求的驗證，只要是會寫入資料庫的物件，都需要告知許可的可寫入屬性有哪些
    params.require(:product).permit(:name, :description, :price, :image)
  end
end