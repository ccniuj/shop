class Admin::InventoriesController < ApplicationController
  before_action :find_product, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_inventory, only: [:edit, :update, :destroy]

  def new
  	@inventory = @product.inventories.new
  end

  def edit
  	@inventory_images = @inventory.inventory_images.all  	
  end

  def create
  	@inventory = @product.inventories.new(inventory_params)

  	if @inventory.save
      new_product_total_amount = @product.total_amout + @inventory.amount
      @product.update({total_amout: new_product_total_amount})
      redirect_to new_admin_product_inventory_inventory_image_path(@product,@inventory), notice: "新增存貨成功"
  	else
      flash[:alert] = "新增存貨失敗，必須輸入顏色、尺寸、數量，數量必須為阿拉伯數字"
      render :new
  	end
  end

  def update
  	old_inventroy_amount = @inventory.amount

    if @inventory.update(inventory_params)
    	new_product_total_amount = @product.total_amout + @inventory.amount - old_inventroy_amount
    	@product.update({total_amout: new_product_total_amount})
    	redirect_to edit_admin_product_inventory_path(@product,@inventory), notice: "變更存貨成功"
    else
      # using render here will cause problem, need to fix later
    	flash[:notice] = "變更存貨失敗，必須輸入顏色、尺寸、數量，數量必須為阿拉伯數字"
      redirect_to edit_admin_product_inventory_path(@product,@inventory)
    end
  end

  def destroy
  	new_product_total_amount = @product.total_amout - @inventory.amount
  	@product.update({total_amout: new_product_total_amount})
  	@inventory.destroy
  	redirect_to edit_admin_product_path(@product), notice: "成功刪除存貨"
  end

  private

  def inventory_params
  	params.require(:inventory).permit(:color, :size, :amount)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_inventory
    @inventory = @product.inventories.find(params[:id])
  end
end
