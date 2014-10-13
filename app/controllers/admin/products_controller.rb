class Admin::ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :destroy]

  def index
  	@products = Product.all
  end

  def new
    @catalogs = Catalog.all.in_groups_of(4)
  	@product = Product.new
  end

  def edit
    @catalogs = Catalog.all.in_groups_of(4)
  	@inventories = @product.inventories
  end

  def create
  	@product = Product.new(product_params)

    if params[:subclass]
      if @product.save
        params[:subclass].each(&:to_i).each do |new_add_id|
          SubclassProduct.create({subclass_id: new_add_id, product_id: @product.id})
        end
  		  redirect_to new_admin_product_inventory_path(@product), notice: "產品新增成功，現在請新增此產品存貨資訊"
      else
        #using render here will cause issue, need to fix later
    		flash[:alert] = "產品新增失敗，名稱、說明、尺寸說明、注意事項、價錢不得為空，且價錢須為阿拉伯數字"
        redirect_to new_admin_product_path
      end
    else
      #using render here will cause issue, need to fix later
      flash[:alert] = "產品新增失敗，必須勾選所屬分類"
      redirect_to new_admin_product_path
  	end
  end

  def update
    if params[:subclass]
    	if @product.update(product_params)
        old_product_class = []
        SubclassProduct.where(product_id: @product.id).each do |item|
          old_product_class << item.subclass_id
        end
        params[:subclass] ? new_product_class = params[:subclass].each(&:to_i) : new_product_class = []
        shall_add = new_product_class - old_product_class
        shall_rm  = old_product_class - new_product_class
        
        shall_add.each do |new_add_id|
          SubclassProduct.create({subclass_id: new_add_id, product_id: @product.id})
        end

        shall_rm.each do |new_rm_id|
          SubclassProduct.where(subclass_id: new_rm_id, product_id: @product.id).first.destroy
        end 
        
    		redirect_to edit_admin_product_path(@product), notice: "產品變更成功"
    	else
    		# using render here will cause problem, need to fix later
        flash[:alert] = "產品變更失敗，名稱、說明、尺寸說明、注意事項、價錢不得為空，且價錢須為阿拉伯數字"
    		redirect_to edit_admin_product_path(@product)
    	end
    else
      #using render here will cause issue, need to fix later
      flash[:alert] = "產品更新失敗，產品必須屬於至少一個分類"
      redirect_to edit_admin_product_path(@product)
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
