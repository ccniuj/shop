class Admin::ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
  	@products = Product.all
  end

  def new
  	@product = Product.new
  end

  def edit
  	@inventories = @product.inventories
  end

  def create
  	@product = Product.new(product_params)

  	if @product.save
  		redirect_to new_admin_product_inventory_path(@product), notice: "產品新增成功"
  	else
  		flash[:alert] = "產品新增失敗，名稱、說明、尺寸說明、注意事項、價錢不得為空，且價錢須為阿拉伯數字"
      render :new
  	end
  end

  def update
  	if @product.update(product_params)
  		redirect_to edit_admin_product_path(@product), notice: "產品變更成功"
  	else
  		# using render here will cause problem, need to fix later
  		redirect_to edit_admin_product_path(@product), alert: "產品變更失敗，名稱、說明、尺寸說明、注意事項、價錢不得為空，且價錢須為阿拉伯數字"
  	end
  end

  def destroy
  	@product.destroy
  	redirect_to admin_products_path, notice: "成功刪除產品"
  end

  private

  def product_params
  	params.require(:product).permit(:name, :description, :size_note, :attention, :price)
  end

  def find_product
  	@product = Product.find(params[:id])
  end
end
