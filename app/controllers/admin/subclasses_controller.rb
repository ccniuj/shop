class Admin::SubclassesController < ApplicationController
  def new
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.new
  end

  def edit
  	@catalog = Catalog.find(params[:catalog_id])
  	@subclass = @catalog.subclasses.find(params[:id])
  end

  def create
  	@catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.new(subclass_params)
    
    if @subclass.save
    	# should redirect_to add product to SubclassProduct page
    	redirect_to edit_admin_catalog_path(@catalog), notice: "類別新增完成"
    else
      render :new, alert: "類別新增失敗"
    end
  end

  def update
  	@catalog = Catalog.find(params[:catalog_id])
  	@subclass = @catalog.subclasses.find(params[:id])

  	if @subclass.update(subclass_params)
  		redirect_to edit_admin_catalog_path(@catalog), notice: "類別更新成功"
  	else
      render :edit, alert: "類別更新失敗"
  	end
  end

  def destroy
  	@catalog = Catalog.find(params[:catalog_id])
  	@subclass = @catalog.subclasses.find(params[:id])

  	@subclass.destroy
  	redirect_to edit_admin_catalog_path(@catalog), notice: "成功刪除類別"
  end

  private

  def subclass_params
  	params.require(:subclass).permit(:name, :description)
  end
end
