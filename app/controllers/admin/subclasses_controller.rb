class Admin::SubclassesController < ApplicationController
  before_action :get_catalog_and_subclass, only: [:edit, :update, :destroy]

  def new
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.new
  end

  def edit
    @products = @subclass.classified_products
  end

  def create
  	@catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.new(subclass_params)
    
    if @subclass.save
    	# should redirect_to add product to SubclassProduct page
    	redirect_to edit_admin_catalog_path(@catalog), notice: "類別新增完成"
    else
      flash[:alert] = "類別新增失敗，必須輸入名稱與說明"
      render :new
    end
  end

  def update
  	if @subclass.update(subclass_params)
  		redirect_to edit_admin_catalog_path(@catalog), notice: "類別更新成功"
  	else
      # using render here will cause problem, need to fix later
      redirect_to edit_admin_catalog_path(@catalog), alert: "類別更新失敗，必須輸入名稱與說明"
  	end
  end

  def destroy
  	@subclass.destroy
  	redirect_to edit_admin_catalog_path(@catalog), notice: "成功刪除類別"
  end

  private

  def subclass_params
  	params.require(:subclass).permit(:name, :description)
  end

  def get_catalog_and_subclass
    @catalog = Catalog.find(params[:catalog_id])
    @subclass = @catalog.subclasses.find(params[:id])
  end
end
