class Admin::InventoryImagesController < ApplicationController
  before_action :find_product_and_inventory, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_inventory_image, only: [:edit, :update, :destroy]

  def new
  	@inventory_image = @inventory.inventory_images.new
  end

  def edit; end

  def create
  	@inventory_image = @inventory.inventory_images.new(inventory_image_params)

  	if @inventory_image.save
  		redirect_to edit_admin_product_inventory_path(@product,@inventory), notice: "新增存貨照片成功"
  	else
  		flash[:alert] = "新增存貨照片失敗，必須輸入相片名稱和敘述"
      render :new
  	end
  end

  def update
  	if @inventory_image.update(inventory_image_params)
  		redirect_to edit_admin_product_inventory_path(@product,@inventory), notice: "變更存貨照片成功"
  	else
      # using render here will cause issue if didn't new successfully
  		flash[:alert] = "變更存貨照片失敗，必須輸入相片名稱和敘述"
      redirect_to edit_admin_product_inventory_inventory_image_path(@product,@inventory,@inventory_image)
  	end
  end

  def destroy
  	@inventory_image.destroy
  	redirect_to edit_admin_product_inventory_path(@product,@inventory), notice: "成功刪除存貨照片"
  end

  private

  def inventory_image_params
  	params.require(:inventory_image).permit(:title, :avatar, :description)
  end

  def find_product_and_inventory
    @product = Product.find(params[:product_id])
    @inventory = @product.inventories.find(params[:inventory_id])
  end

  def find_inventory_image
    @inventory_image = @inventory.inventory_images.find(params[:id])
  end
end
